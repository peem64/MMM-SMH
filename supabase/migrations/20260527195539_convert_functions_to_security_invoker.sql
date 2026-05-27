/*
  # Convert SECURITY DEFINER functions to SECURITY INVOKER

  1. Changes
    - toggle_mountain_completion: switch to SECURITY INVOKER
    - get_user_completion_stats: switch to SECURITY INVOKER

  2. Reasoning
    Both functions only access tables (mountain_completions, munros, corbetts) that are
    already protected by RLS. Running as SECURITY INVOKER means queries execute as the
    calling user, so RLS policies apply normally. There is no need for elevated privileges,
    and SECURITY DEFINER was creating an unnecessary attack surface via the RPC endpoint.
*/

CREATE OR REPLACE FUNCTION public.toggle_mountain_completion(
  mountain_uuid text,
  mountain_type_param text,
  completion_notes text DEFAULT ''::text
)
  RETURNS TABLE(action text, completed boolean, completion_date timestamp with time zone)
  LANGUAGE plpgsql
  SECURITY INVOKER
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
  SECURITY INVOKER
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
