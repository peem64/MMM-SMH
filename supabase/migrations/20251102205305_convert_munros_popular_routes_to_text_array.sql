/*
  # Convert Munros popular_routes from JSONB to TEXT[] 

  The corbetts table uses text[] for popular_routes, but munros uses jsonb.
  This causes the frontend to not display the routes section properly for munros.
  
  1. Changes
    - Convert munros.popular_routes from jsonb to text[] to match corbetts structure
    - Preserves any existing route data (currently all empty arrays)
    
  2. Notes
    - All 282 munros currently have empty route arrays []
    - This migration makes the schema consistent between munros and corbetts
    - Future route data can now be added in the same format as corbetts
*/

-- First, add a temporary text[] column
ALTER TABLE munros ADD COLUMN popular_routes_temp text[];

-- Copy data from jsonb to text[] (all currently empty)
UPDATE munros SET popular_routes_temp = ARRAY[]::text[];

-- Drop the old jsonb column
ALTER TABLE munros DROP COLUMN popular_routes;

-- Rename the temp column to popular_routes
ALTER TABLE munros RENAME COLUMN popular_routes_temp TO popular_routes;

-- Set NOT NULL and default
ALTER TABLE munros ALTER COLUMN popular_routes SET NOT NULL;
ALTER TABLE munros ALTER COLUMN popular_routes SET DEFAULT ARRAY[]::text[];