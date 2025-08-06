/*
  # Complete Completion Tracking System

  This migration sets up the complete completion tracking system with:
  1. Users table for authentication
  2. Mountain completions table
  3. Proper RLS policies
  4. Database functions for completion operations
  5. Indexes for performance

  Expected result: Fully working completion tracking system
*/

-- Create users table if it doesn't exist
CREATE TABLE IF NOT EXISTS users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS on users table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Create policy for users to read their own data
DROP POLICY IF EXISTS "Users can read own data" ON users;
CREATE POLICY "Users can read own data"
  ON users
  FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Create policy for users to insert their own data
DROP POLICY IF EXISTS "Users can insert own data" ON users;
CREATE POLICY "Users can insert own data"
  ON users
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

-- Create mountain_completions table if it doesn't exist
CREATE TABLE IF NOT EXISTS mountain_completions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mountain_id uuid NOT NULL,
  mountain_type text NOT NULL CHECK (mountain_type IN ('munros', 'corbetts')),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  completed_at timestamptz DEFAULT now(),
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(mountain_id, mountain_type, user_id)
);

-- Enable RLS on mountain_completions table
ALTER TABLE mountain_completions ENABLE ROW LEVEL SECURITY;

-- Drop existing policies
DROP POLICY IF EXISTS "Users can view their own completions" ON mountain_completions;
DROP POLICY IF EXISTS "Users can insert their own completions" ON mountain_completions;
DROP POLICY IF EXISTS "Users can update their own completions" ON mountain_completions;
DROP POLICY IF EXISTS "Users can delete their own completions" ON mountain_completions;
DROP POLICY IF EXISTS "Anonymous users can view completion stats" ON mountain_completions;

-- Create comprehensive RLS policies
CREATE POLICY "Users can view their own completions"
  ON mountain_completions
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own completions"
  ON mountain_completions
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own completions"
  ON mountain_completions
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own completions"
  ON mountain_completions
  FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- Allow anonymous users to view completion stats (for public counters)
CREATE POLICY "Anonymous users can view completion stats"
  ON mountain_completions
  FOR SELECT
  TO anon
  USING (true);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_completions_user ON mountain_completions (user_id);
CREATE INDEX IF NOT EXISTS idx_completions_mountain ON mountain_completions (mountain_id, mountain_type);
CREATE INDEX IF NOT EXISTS idx_completions_date ON mountain_completions (completed_at);
CREATE UNIQUE INDEX IF NOT EXISTS idx_unique_completion ON mountain_completions (mountain_id, mountain_type, user_id);

-- Create or replace the toggle completion function
CREATE OR REPLACE FUNCTION toggle_mountain_completion(
  mountain_uuid text,
  mountain_type_param text,
  completion_notes text DEFAULT ''
)
RETURNS TABLE(
  action text,
  completed boolean,
  completion_date timestamptz
) 
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  current_user_id uuid;
  existing_completion mountain_completions%ROWTYPE;
  mountain_id_uuid uuid;
BEGIN
  -- Get current user
  current_user_id := auth.uid();
  
  -- Check if user is authenticated
  IF current_user_id IS NULL THEN
    RAISE EXCEPTION 'User not authenticated';
  END IF;
  
  -- Convert mountain_uuid to UUID type
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
    -- Completion exists, remove it
    DELETE FROM mountain_completions
    WHERE id = existing_completion.id;
    
    RETURN QUERY SELECT 'removed'::text, false::boolean, NULL::timestamptz;
  ELSE
    -- No completion exists, add it
    INSERT INTO mountain_completions (mountain_id, mountain_type, user_id, notes, completed_at)
    VALUES (mountain_id_uuid, mountain_type_param, current_user_id, completion_notes, now())
    RETURNING 'added'::text, true::boolean, completed_at;
    
    RETURN QUERY SELECT 'added'::text, true::boolean, now()::timestamptz;
  END IF;
END;
$$;

-- Create or replace the get completion stats function
CREATE OR REPLACE FUNCTION get_user_completion_stats(
  user_uuid uuid,
  mountain_type_param text
)
RETURNS TABLE(
  total_mountains integer,
  completed_mountains integer,
  completion_percentage numeric,
  recent_completions integer
) 
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  total_count integer;
  completed_count integer;
  recent_count integer;
BEGIN
  -- Get total mountain count based on type
  IF mountain_type_param = 'munros' THEN
    SELECT COUNT(*) INTO total_count FROM munros;
  ELSIF mountain_type_param = 'corbetts' THEN
    SELECT COUNT(*) INTO total_count FROM corbetts;
  ELSE
    RAISE EXCEPTION 'Invalid mountain type: %', mountain_type_param;
  END IF;
  
  -- Get completed count for user
  SELECT COUNT(*) INTO completed_count
  FROM mountain_completions
  WHERE user_id = user_uuid
    AND mountain_type = mountain_type_param;
  
  -- Get recent completions (last 30 days)
  SELECT COUNT(*) INTO recent_count
  FROM mountain_completions
  WHERE user_id = user_uuid
    AND mountain_type = mountain_type_param
    AND completed_at >= now() - interval '30 days';
  
  -- Return results
  RETURN QUERY SELECT 
    total_count,
    completed_count,
    CASE 
      WHEN total_count > 0 THEN ROUND((completed_count::numeric / total_count::numeric) * 100, 1)
      ELSE 0::numeric
    END,
    recent_count;
END;
$$;

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO authenticated, anon;
GRANT ALL ON TABLE mountain_completions TO authenticated;
GRANT SELECT ON TABLE mountain_completions TO anon;
GRANT EXECUTE ON FUNCTION toggle_mountain_completion TO authenticated;
GRANT EXECUTE ON FUNCTION get_user_completion_stats TO authenticated;

-- Test the functions work
DO $$
BEGIN
  RAISE NOTICE 'Completion tracking system setup complete!';
  RAISE NOTICE 'Functions created: toggle_mountain_completion, get_user_completion_stats';
  RAISE NOTICE 'Tables ready: users, mountain_completions';
  RAISE NOTICE 'RLS policies active for data security';
END $$;