/*

---------- ADDITIONAL COMMANDS --------------

-- Show all available databases:
SHOW DATABASES;

-- To check info of the created Schema:
SELECT * FROM information_schema.schemata; 

-- To check the properties of the table inside the database:
SELECT *
FROM information_schema.TABLES
WHERE table_catalog = 'job_mart';

*/

/*
Copy & Paste to run this whole file
.read Lessons/1.21/1.21_DDL_DML_Pt1.sql

*/

-- CREATING A WHOLE NEW DATABASE WITH SCHEMA & TABLES

-- Make sure to USE a different database first.
USE data_jobs;
-- Drop it first, to have a clean database
DROP DATABASE IF EXISTS job_mart;


-- CREATING the database
CREATE DATABASE IF NOT EXISTS job_mart;  
-- TO ADD THE SCHEMA in job_mart not other databses,
USE job_mart;

-- CREATING schema
CREATE SCHEMA IF NOT EXISTS staging;

-- CREATING Tables
CREATE TABLE IF NOT EXISTS staging.preferred_roles (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

-- INSERTING new data
INSERT INTO staging.preferred_roles(
    role_id, 
    role_name
) VALUES 
    (1, 'Data Engineer'),
    (2, 'Sr. Data Engineer'),
    (3, 'Software Engineer');

-- SELECT * FROM staging.preferred_roles;

-- ALTER tables: Adding new columns
ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

-- UPDATE table: 
UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 OR role_id=2;

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

-- ALTER tables: changing table name
ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT * FROM staging.priority_roles;

-- ALTER tables: changing column name
ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

-- ALTER tables: changing column values
ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

-- UPDATE table: changing the priority lvls
UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

SELECT * FROM staging.priority_roles;






