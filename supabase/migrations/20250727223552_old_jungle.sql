/*
  # Remove Leum Uilleim from Munros table

  Leum Uilleim is a Corbett (906m), not a Munro. This migration removes it from the Munros table
  to correct the database corruption where Corbetts were incorrectly included in the Munros dataset.

  1. Changes
     - Remove Leum Uilleim from munros table
     - This peak should only exist in the corbetts table

  2. Background
     - Leum Uilleim: 906m, located in Lochaber
     - Classification: Corbett (not Munro - under 914.4m/3000ft threshold)
     - This fixes database corruption where non-Munros were included
*/

-- Remove Leum Uilleim as it's a Corbett, not a Munro
DELETE FROM munros 
WHERE name = 'Leum Uilleim' 
   OR name ILIKE '%Leum Uilleim%';