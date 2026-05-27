/*
  # Fix function security issues

  1. Changes
    - Add SET search_path = '' to all functions to prevent mutable search_path vulnerability
    - Revoke EXECUTE from anon and authenticated roles on SECURITY DEFINER functions
      that should not be publicly callable via RPC
    - handle_new_user is a trigger function and should not be callable via RPC at all
    - toggle_mountain_completion and get_user_completion_stats are restricted to authenticated only

  2. Security
    - Mutable search_path allows attackers to hijack function execution via schema injection
    - Locking search_path to '' and using fully qualified names prevents this
    - anon role should never execute SECURITY DEFINER functions that access user data
*/

-- Fix update_updated_at_column: add immutable search_path
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
  RETURNS trigger
  LANGUAGE plpgsql
  SET search_path = ''
AS $function$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$function$;

-- Fix handle_new_user: already has search_path set, revoke public RPC access
-- It's a trigger-only function and should never be called directly
REVOKE EXECUTE ON FUNCTION public.handle_new_user() FROM anon, authenticated, PUBLIC;

-- Fix toggle_mountain_completion: add immutable search_path, restrict to authenticated only
CREATE OR REPLACE FUNCTION public.toggle_mountain_completion(
  mountain_uuid text,
  mountain_type_param text,
  completion_notes text DEFAULT ''::text
)
  RETURNS TABLE(action text, completed boolean, completion_date timestamp with time zone)
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path = ''
AS $function$
DECLARE
  current_user_id uuid;
  mountain_id_uuid uuid;
  existing_completion public.mountain_completions%ROWTYPE;
BEGIN
  current_user_id := auth.uid();

  IF current_user_id IS NULL THEN
    RAISE EXCEPTION 'User not authenticated';
  END IF;

  BEGIN
    mountain_id_uuid := mountain_uuid::uuid;
  EXCEPTION WHEN invalid_text_representation THEN
    RAISE EXCEPTION 'Invalid mountain ID format: %', mountain_uuid;
  END;

  SELECT * INTO existing_completion
  FROM public.mountain_completions
  WHERE mountain_id = mountain_id_uuid
    AND mountain_type = mountain_type_param
    AND user_id = current_user_id;

  IF existing_completion.id IS NOT NULL THEN
    DELETE FROM public.mountain_completions
    WHERE id = existing_completion.id;

    RETURN QUERY SELECT
      'removed'::text AS action,
      false AS completed,
      NULL::timestamptz AS completion_date;
  ELSE
    INSERT INTO public.mountain_completions (
      mountain_id,
      mountain_type,
      user_id,
      notes,
      completed_at
    ) VALUES (
      mountain_id_uuid,
      mountain_type_param,
      current_user_id,
      completion_notes,
      NOW()
    );

    RETURN QUERY SELECT
      'added'::text AS action,
      true AS completed,
      NOW() AS completion_date;
  END IF;
END;
$function$;

REVOKE EXECUTE ON FUNCTION public.toggle_mountain_completion(text, text, text) FROM anon, PUBLIC;
GRANT EXECUTE ON FUNCTION public.toggle_mountain_completion(text, text, text) TO authenticated;

-- Fix get_user_completion_stats: add immutable search_path, restrict to authenticated only
CREATE OR REPLACE FUNCTION public.get_user_completion_stats(
  user_uuid uuid,
  mountain_type_param text DEFAULT 'munros'::text
)
  RETURNS TABLE(
    total_mountains integer,
    completed_mountains integer,
    completion_percentage numeric,
    recent_completions integer
  )
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path = ''
AS $function$
BEGIN
  IF mountain_type_param = 'munros' THEN
    SELECT COUNT(*)::integer INTO total_mountains FROM public.munros;
  ELSE
    SELECT COUNT(*)::integer INTO total_mountains FROM public.corbetts;
  END IF;

  SELECT COUNT(*)::integer INTO completed_mountains
  FROM public.mountain_completions
  WHERE user_id = user_uuid
    AND mountain_type = mountain_type_param;

  IF total_mountains > 0 THEN
    completion_percentage := ROUND((completed_mountains::numeric / total_mountains::numeric) * 100, 1);
  ELSE
    completion_percentage := 0;
  END IF;

  SELECT COUNT(*)::integer INTO recent_completions
  FROM public.mountain_completions
  WHERE user_id = user_uuid
    AND mountain_type = mountain_type_param
    AND completed_at >= NOW() - INTERVAL '30 days';

  RETURN QUERY SELECT
    total_mountains,
    completed_mountains,
    completion_percentage,
    recent_completions;
END;
$function$;

REVOKE EXECUTE ON FUNCTION public.get_user_completion_stats(uuid, text) FROM anon, PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_user_completion_stats(uuid, text) TO authenticated;
