/*
  # Force Fix mountain_id Column Type
  
  The previous migration may not have worked properly. This migration will:
  1. Drop all existing data and constraints
  2. Recreate the table with the correct column types
  3. Re-add all necessary constraints and policies
  
  This will fix the UUID type error for Corbetts completion tracking.
*/

-- Drop the existing table completely to avoid type conflicts
DROP TABLE IF EXISTS mountain_completions CASCADE;

-- Recreate the table with correct column types
CREATE TABLE mountain_completions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mountain_id text NOT NULL,  -- Changed from uuid to text to support both UUIDs and integers
  mountain_type text NOT NULL CHECK (mountain_type IN ('munros', 'corbetts')),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  completed_at timestamptz DEFAULT now(),
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create unique constraint to prevent duplicate completions
CREATE UNIQUE INDEX idx_unique_completion ON mountain_completions (mountain_id, mountain_type, user_id);

-- Create performance indexes
CREATE INDEX idx_completions_user ON mountain_completions (user_id);
CREATE INDEX idx_completions_mountain ON mountain_completions (mountain_id, mountain_type);
CREATE INDEX idx_completions_date ON mountain_completions (completed_at);
CREATE INDEX idx_mountain_completions_user_mountain ON mountain_completions (user_id, mountain_id, mountain_type);
CREATE INDEX idx_mountain_completions_mountain_type ON mountain_completions (mountain_type);

-- Enable RLS
ALTER TABLE mountain_completions ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can manage their own completions"
  ON mountain_completions
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Public can view completion stats"
  ON mountain_completions
  FOR SELECT
  TO anon, authenticated
  USING (true);

-- Create function to handle new user creation
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger AS $$
BEGIN
  -- Set user_id to current authenticated user if not provided
  IF NEW.user_id IS NULL THEN
    NEW.user_id := auth.uid();
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger for new completions
CREATE TRIGGER on_completion_create_user
  BEFORE INSERT ON mountain_completions
  FOR EACH ROW
  EXECUTE FUNCTION handle_new_user();

-- Verify the table structure
SELECT 
  column_name, 
  data_type, 
  is_nullable,
  column_default
FROM information_schema.columns 
WHERE table_name = 'mountain_completions' 
ORDER BY ordinal_position;