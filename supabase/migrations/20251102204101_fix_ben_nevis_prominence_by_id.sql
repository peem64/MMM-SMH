/*
  # Fix Ben Nevis Prominence - Direct ID Update

  Ben Nevis is the only remaining munro with incorrect prominence.
  Database has: height 1345m, prominence 1345m
  Should be: height 1345m, prominence 1344.5m
  
  Using direct ID update to ensure it applies.

  1. Updates
    - Sets Ben Nevis prominence to 1344.5m using its UUID
*/

UPDATE munros 
SET prominence_m = 1344.5 
WHERE id = '9513cf82-1528-460f-ac58-6c18dc219201'::uuid;