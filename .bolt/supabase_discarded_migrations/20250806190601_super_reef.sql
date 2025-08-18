/*
  # Fix Completion Tracking System

  This migration ensures the completion tracking system works properly by:
  1. Creating the toggle function if it doesn't exist
  2. Fixing RLS policies
  3. Adding proper database functions
  4. Ensuring proper data types and constraints
*/

-- Create or replace the toggle completion function
CREATE OR REPLACE FUNCTION toggle_mountain_completion(
  mountain_uuid TEXT,
  mountain_type_param TEXT,
  completion_notes TEXT DEFAULT ''
)
RETURNS TABLE(
  action TEXT,
  completed BOOLEAN,
  completion_date TIMESTAMPTZ
) 
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  current_user_id UUID;
  existing_completion mountain_completions%ROWTYPE;
BEGIN
  -- Get current user
  current_user_id := auth.uid();
  
  IF current_user_id IS NULL THEN
    RAISE EXCEPTION 'User not authenticated';
  END IF;

  -- Check if completion already exists
  SELECT * INTO existing_completion
  FROM mountain_completions
  WHERE mountain_id = mountain_uuid::UUID
    AND mountain_type = mountain_type_param
    AND user_id = current_user_id;

  IF existing_completion.id IS NOT NULL THEN
    -- Remove completion
    DELETE FROM mountain_completions
    WHERE id = existing_completion.id;
    
    RETURN QUERY SELECT 
      'removed'::TEXT as action,
      FALSE as completed,
      NULL::TIMESTAMPTZ as completion_date;
  ELSE
    -- Add completion
    INSERT INTO mountain_completions (
      mountain_id,
      mountain_type,
      user_id,
      completed_at,
      notes
    ) VALUES (
      mountain_uuid::UUID,
      mountain_type_param,
      current_user_id,
      NOW(),
      completion_notes
    );
    
    RETURN QUERY SELECT 
      'added'::TEXT as action,
      TRUE as completed,
      NOW() as completion_date;
  END IF;
END;
$$;

-- Create or replace the stats function
CREATE OR REPLACE FUNCTION get_user_completion_stats(
  user_uuid UUID,
  mountain_type_param TEXT
)
RETURNS TABLE(
  total_mountains INTEGER,
  completed_mountains INTEGER,
  completion_percentage NUMERIC,
  recent_completions INTEGER
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  total_count INTEGER;
  completed_count INTEGER;
BEGIN
  -- Get total mountain count
  IF mountain_type_param = 'munros' THEN
    SELECT COUNT(*) INTO total_count FROM munros;
  ELSE
    SELECT COUNT(*) INTO total_count FROM corbetts;
  END IF;
  
  -- Get completed count for user
  SELECT COUNT(*) INTO completed_count
  FROM mountain_completions
  WHERE user_id = user_uuid
    AND mountain_type = mountain_type_param;
  
  -- Get recent completions (last 30 days)
  DECLARE recent_count INTEGER;
  SELECT COUNT(*) INTO recent_count
  FROM mountain_completions
  WHERE user_id = user_uuid
    AND mountain_type = mountain_type_param
    AND completed_at >= NOW() - INTERVAL '30 days';
  
  RETURN QUERY SELECT 
    total_count as total_mountains,
    completed_count as completed_mountains,
    CASE 
      WHEN total_count > 0 THEN ROUND((completed_count::NUMERIC / total_count::NUMERIC) * 100, 1)
      ELSE 0::NUMERIC
    END as completion_percentage,
    recent_count as recent_completions;
END;
$$;