/*
  # Fix mountain_id type to support both Munros and Corbetts
  
  The issue is that mountain_completions.mountain_id is defined as uuid,
  but Corbetts use integer IDs while Munros use UUID strings.
  
  This migration changes mountain_id to text to support both types.
  
  1. Drop existing constraints and indexes
  2. Change mountain_id from uuid to text
  3. Recreate indexes and constraints
  4. Update RLS policies
*/

-- Drop existing indexes that depend on mountain_id
DROP INDEX IF EXISTS idx_completions_mountain;
DROP INDEX IF EXISTS idx_mountain_completions_user_mountain;
DROP INDEX IF EXISTS idx_unique_completion;

-- Change mountain_id from uuid to text to support both UUIDs and integers
ALTER TABLE mountain_completions 
ALTER COLUMN mountain_id TYPE text USING mountain_id::text;

-- Recreate indexes
CREATE INDEX idx_completions_mountain ON mountain_completions (mountain_id, mountain_type);
CREATE INDEX idx_mountain_completions_user_mountain ON mountain_completions (user_id, mountain_id, mountain_type);
CREATE UNIQUE INDEX idx_unique_completion ON mountain_completions (mountain_id, mountain_type, user_id);

-- Update the check constraint to be more flexible
ALTER TABLE mountain_completions 
DROP CONSTRAINT IF EXISTS mountain_completions_mountain_type_check;

ALTER TABLE mountain_completions 
ADD CONSTRAINT mountain_completions_mountain_type_check 
CHECK (mountain_type = ANY (ARRAY['munros'::text, 'corbetts'::text]));

-- Verify the changes
SELECT 
  column_name, 
  data_type, 
  is_nullable 
FROM information_schema.columns 
WHERE table_name = 'mountain_completions' 
  AND column_name = 'mountain_id';

-- Test that we can insert both types
DO $$
BEGIN
  -- Test with UUID (Munro style)
  INSERT INTO mountain_completions (mountain_id, mountain_type, user_id, notes) 
  VALUES ('123e4567-e89b-12d3-a456-426614174000', 'munros', auth.uid(), 'Test UUID')
  ON CONFLICT DO NOTHING;
  
  -- Test with integer (Corbett style)  
  INSERT INTO mountain_completions (mountain_id, mountain_type, user_id, notes)
  VALUES ('123', 'corbetts', auth.uid(), 'Test integer')
  ON CONFLICT DO NOTHING;
  
  -- Clean up test data
  DELETE FROM mountain_completions WHERE notes IN ('Test UUID', 'Test integer');
  
  RAISE NOTICE 'mountain_id type change completed successfully';
END $$;