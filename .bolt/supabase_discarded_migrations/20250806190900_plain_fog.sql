/*
  # Fix Function Parameter Error
  
  This migration fixes the function parameter error by properly dropping and recreating functions.
  
  1. Drop existing functions that may have different signatures
  2. Recreate functions with correct parameters
  3. Ensure proper RLS policies are in place
*/

-- Drop existing functions if they exist (with any signature variations)
DROP FUNCTION IF EXISTS get_user_completion_stats(uuid, text);
DROP FUNCTION IF EXISTS get_user_completion_stats(text, text);
DROP FUNCTION IF EXISTS toggle_mountain_completion(uuid, text, text);
DROP FUNCTION IF EXISTS toggle_mountain_completion(text, text, text);

-- Recreate the get_user_completion_stats function
CREATE OR REPLACE FUNCTION get_user_completion_stats(
  user_uuid uuid,
  mountain_type_param text DEFAULT 'munros'
)
RETURNS TABLE (
  total_mountains integer,
  completed_mountains integer,
  completion_percentage numeric,
  recent_completions integer
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Get total mountains for the type
  IF mountain_type_param = 'munros' THEN
    SELECT COUNT(*)::integer INTO total_mountains FROM munros;
  ELSE
    SELECT COUNT(*)::integer INTO total_mountains FROM corbetts;
  END IF;
  
  -- Get completed mountains count
  SELECT COUNT(*)::integer INTO completed_mountains
  FROM mountain_completions
  WHERE user_id = user_uuid 
    AND mountain_type = mountain_type_param;
  
  -- Calculate completion percentage
  IF total_mountains > 0 THEN
    completion_percentage := ROUND((completed_mountains::numeric / total_mountains::numeric) * 100, 1);
  ELSE
    completion_percentage := 0;
  END IF;
  
  -- Get recent completions (last 30 days)
  SELECT COUNT(*)::integer INTO recent_completions
  FROM mountain_completions
  WHERE user_id = user_uuid 
    AND mountain_type = mountain_type_param
    AND completed_at >= NOW() - INTERVAL '30 days';
  
  RETURN QUERY SELECT 
    total_mountains,
    completed_mountains,
    completion_percentage,
    recent_completions;
END;
$$;

-- Recreate the toggle_mountain_completion function
CREATE OR REPLACE FUNCTION toggle_mountain_completion(
  mountain_uuid text,
  mountain_type_param text,
  completion_notes text DEFAULT ''
)
RETURNS TABLE (
  action text,
  completed boolean,
  completion_date timestamptz
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  current_user_id uuid;
  mountain_id_uuid uuid;
  existing_completion mountain_completions%ROWTYPE;
BEGIN
  -- Get current user
  current_user_id := auth.uid();
  
  IF current_user_id IS NULL THEN
    RAISE EXCEPTION 'User not authenticated';
  END IF;
  
  -- Convert mountain_uuid to proper UUID
  BEGIN
    mountain_id_uuid := mountain_uuid::uuid;
  EXCEPTION WHEN invalid_text_representation THEN
    RAISE EXCEPTION 'Invalid mountain ID format: %', mountain_uuid;
  END;
  
  -- Check if completion already exists
  SELECT * INTO existing_completion
  FROM mountain_completions
  WHERE mountain_id = mountain_id_uuid
    AND mountain_type = mountain_type_param
    AND user_id = current_user_id;
  
  IF existing_completion.id IS NOT NULL THEN
    -- Remove completion
    DELETE FROM mountain_completions
    WHERE id = existing_completion.id;
    
    RETURN QUERY SELECT 
      'removed'::text as action,
      false as completed,
      NULL::timestamptz as completion_date;
  ELSE
    -- Add completion
    INSERT INTO mountain_completions (
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
      'added'::text as action,
      true as completed,
      NOW() as completion_date;
  END IF;
END;
$$;

-- Grant execute permissions
GRANT EXECUTE ON FUNCTION get_user_completion_stats(uuid, text) TO authenticated;
GRANT EXECUTE ON FUNCTION toggle_mountain_completion(text, text, text) TO authenticated;

-- Verify the functions work
SELECT 'Functions created successfully' as status;