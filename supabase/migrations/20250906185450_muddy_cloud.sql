/*
  # Fix Completion Tracking Issues
  
  This migration fixes the completion tracking system by:
  1. Creating the missing users table
  2. Fixing RLS policies for mountain_completions
  3. Ensuring proper foreign key relationships
  4. Adding proper indexes for performance
  
  This should resolve the 400 errors when trying to track completions.
*/

-- Create users table if it doesn't exist
CREATE TABLE IF NOT EXISTS users (
  id uuid PRIMARY KEY DEFAULT auth.uid(),
  email text UNIQUE,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS on users table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Create policy for users to manage their own data
CREATE POLICY "Users can manage own data"
  ON users
  FOR ALL
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Drop existing foreign key constraint if it exists
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.table_constraints 
    WHERE constraint_name = 'mountain_completions_user_id_fkey'
  ) THEN
    ALTER TABLE mountain_completions DROP CONSTRAINT mountain_completions_user_id_fkey;
  END IF;
END $$;

-- Add proper foreign key constraint
ALTER TABLE mountain_completions 
ADD CONSTRAINT mountain_completions_user_id_fkey 
FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

-- Update RLS policies for mountain_completions to be more permissive for debugging
DROP POLICY IF EXISTS "Users can view their own completions" ON mountain_completions;
DROP POLICY IF EXISTS "Users can insert their own completions" ON mountain_completions;
DROP POLICY IF EXISTS "Users can update their own completions" ON mountain_completions;
DROP POLICY IF EXISTS "Users can delete their own completions" ON mountain_completions;
DROP POLICY IF EXISTS "Anonymous users can view completion stats" ON mountain_completions;

-- Create new, more permissive policies
CREATE POLICY "Users can manage their own completions"
  ON mountain_completions
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Allow anonymous users to view completion stats (for public leaderboards, etc.)
CREATE POLICY "Public can view completion stats"
  ON mountain_completions
  FOR SELECT
  TO anon, authenticated
  USING (true);

-- Create function to automatically create user record on first completion
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO users (id, email)
  VALUES (NEW.user_id, (SELECT email FROM auth.users WHERE id = NEW.user_id))
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger to auto-create user records
DROP TRIGGER IF EXISTS on_completion_create_user ON mountain_completions;
CREATE TRIGGER on_completion_create_user
  BEFORE INSERT ON mountain_completions
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Add indexes for better performance
CREATE INDEX IF NOT EXISTS idx_mountain_completions_user_mountain 
ON mountain_completions (user_id, mountain_id, mountain_type);

CREATE INDEX IF NOT EXISTS idx_mountain_completions_mountain_type 
ON mountain_completions (mountain_type);

-- Verify the setup
SELECT 
  'mountain_completions' as table_name,
  COUNT(*) as row_count
FROM mountain_completions
UNION ALL
SELECT 
  'users' as table_name,
  COUNT(*) as row_count
FROM users;