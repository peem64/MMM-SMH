/*
  # Fix completion trigger issue

  1. Changes
    - Drop the incorrectly placed trigger on mountain_completions table
    - The trigger should only be on auth.users, not mountain_completions
    - This was causing completion inserts to fail

  2. Notes
    - The handle_new_user function expects auth.users fields (id, email, created_at, updated_at)
    - mountain_completions has different fields, causing the trigger to fail
*/

-- Drop the incorrectly placed trigger
DROP TRIGGER IF EXISTS on_completion_create_user ON mountain_completions;
