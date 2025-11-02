/*
  # Fix Ben Nevis Prominence - Final Update

  The previous migration didn't update Ben Nevis due to character encoding issues.
  This migration explicitly fixes Ben Nevis using height-based matching.

  1. Updates
    - Sets Ben Nevis prominence to 1344.5m (the mountain with height 1345m)
    - This is the last remaining munro with incorrect prominence
*/

UPDATE munros 
SET prominence_m = 1344.5 
WHERE height_m = 1345 
  AND ABS(prominence_m - 1345) < 1;