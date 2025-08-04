/*
  # Add Mountain Completion Tracking

  1. New Tables
    - `mountain_completions`
      - `id` (uuid, primary key)
      - `mountain_id` (uuid, foreign key to munros)
      - `mountain_type` (text, 'munros' or 'corbetts')
      - `user_id` (uuid, references auth.users)
      - `completed_at` (timestamp)
      - `notes` (text, optional completion notes)

  2. Security
    - Enable RLS on `mountain_completions` table
    - Add policies for users to manage their own completions

  3. Functions
    - Helper functions to get completion stats
*/

-- Create mountain completions table
CREATE TABLE IF NOT EXISTS mountain_completions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mountain_id uuid NOT NULL,
  mountain_type text NOT NULL CHECK (mountain_type IN ('munros', 'corbetts')),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  completed_at timestamptz DEFAULT now(),
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create unique constraint to prevent duplicate completions
CREATE UNIQUE INDEX IF NOT EXISTS idx_unique_completion 
ON mountain_completions (mountain_id, mountain_type, user_id);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_completions_user ON mountain_completions (user_id);
CREATE INDEX IF NOT EXISTS idx_completions_mountain ON mountain_completions (mountain_id, mountain_type);
CREATE INDEX IF NOT EXISTS idx_completions_date ON mountain_completions (completed_at);

-- Enable RLS
ALTER TABLE mountain_completions ENABLE ROW LEVEL SECURITY;

-- Create policies for completion tracking
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

-- Allow anonymous users to view completion counts (for public stats)
CREATE POLICY "Anonymous users can view completion stats"
  ON mountain_completions
  FOR SELECT
  TO anon
  USING (true);

-- Create function to get user completion stats
CREATE OR REPLACE FUNCTION get_user_completion_stats(user_uuid uuid, mountain_type_param text DEFAULT 'munros')
RETURNS TABLE (
  total_mountains integer,
  completed_mountains integer,
  completion_percentage numeric,
  recent_completions integer
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    CASE 
      WHEN mountain_type_param = 'munros' THEN (SELECT COUNT(*)::integer FROM munros)
      WHEN mountain_type_param = 'corbetts' THEN (SELECT COUNT(*)::integer FROM corbetts)
      ELSE 0
    END as total_mountains,
    (SELECT COUNT(*)::integer FROM mountain_completions 
     WHERE user_id = user_uuid AND mountain_type = mountain_type_param) as completed_mountains,
    CASE 
      WHEN mountain_type_param = 'munros' THEN 
        ROUND((SELECT COUNT(*)::numeric FROM mountain_completions WHERE user_id = user_uuid AND mountain_type = mountain_type_param) / 
              (SELECT COUNT(*)::numeric FROM munros) * 100, 1)
      WHEN mountain_type_param = 'corbetts' THEN 
        ROUND((SELECT COUNT(*)::numeric FROM mountain_completions WHERE user_id = user_uuid AND mountain_type = mountain_type_param) / 
              (SELECT COUNT(*)::numeric FROM corbetts) * 100, 1)
      ELSE 0::numeric
    END as completion_percentage,
    (SELECT COUNT(*)::integer FROM mountain_completions 
     WHERE user_id = user_uuid 
     AND mountain_type = mountain_type_param 
     AND completed_at > NOW() - INTERVAL '30 days') as recent_completions;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create function to toggle mountain completion
CREATE OR REPLACE FUNCTION toggle_mountain_completion(
  mountain_uuid uuid,
  mountain_type_param text,
  completion_notes text DEFAULT ''
)
RETURNS TABLE (
  action text,
  completed boolean,
  completion_date timestamptz
) AS $$
DECLARE
  existing_completion mountain_completions%ROWTYPE;
  user_uuid uuid;
BEGIN
  -- Get current user
  user_uuid := auth.uid();
  
  IF user_uuid IS NULL THEN
    RAISE EXCEPTION 'User must be authenticated';
  END IF;
  
  -- Check if completion already exists
  SELECT * INTO existing_completion
  FROM mountain_completions 
  WHERE mountain_id = mountain_uuid 
  AND mountain_type = mountain_type_param 
  AND user_id = user_uuid;
  
  IF existing_completion.id IS NOT NULL THEN
    -- Remove completion
    DELETE FROM mountain_completions 
    WHERE id = existing_completion.id;
    
    RETURN QUERY SELECT 'removed'::text, false, NULL::timestamptz;
  ELSE
    -- Add completion
    INSERT INTO mountain_completions (mountain_id, mountain_type, user_id, notes)
    VALUES (mountain_uuid, mountain_type_param, user_uuid, completion_notes)
    RETURNING 'added'::text, true, completed_at;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;