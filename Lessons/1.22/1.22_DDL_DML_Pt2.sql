/*
Connects to job_mart database

.read Lessons/1.22/1.22_DDL_DML_Pt2.sql
*/

-- CTAS, Create table as SELECT

CREATE OR REPLACE TABLE staging.job_postings_flat AS 
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name,
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id;

--CHECKER
SELECT COUNT(*) FROM staging.job_postings_flat;


-- Creating a VIEW, by combining the priority_jobs and job_postings_flat

CREATE OR REPLACE VIEW staging.priority_jobs_flat_view AS
SELECT
    jpf.*
FROM staging.job_postings_flat AS jpf
JOIN staging.priority_roles AS r
    ON jpf.job_title_short = r.role_name
WHERE r.priority_lvl = 1;

-- CHECKER
SELECT 
    job_title_short,
    COUNT(*) AS job_count 
FROM staging.priority_jobs_flat_view
GROUP BY job_title_short
ORDER BY job_count DESC;

-- TEMP table, a session-only scope table. 
CREATE TEMPORARY TABLE senior_jobs_flat_temp AS
SELECT * 
FROM staging.priority_jobs_flat_view
WHERE job_title_short = 'Senior Data Engineer';

-- CHEKER
SELECT 
    job_title_short,
    COUNT(*) AS job_count 
FROM senior_jobs_flat_temp
GROUP BY job_title_short
ORDER BY job_count DESC;


/*
----------- DELETE, TRUNCATE, DROP TABLE ---------------
*/

-- DELETING jobs from before January 1, 2024

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;

DELETE FROM staging.job_postings_flat
WHERE job_posted_date < '2024-01-01';

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;


-- TRUNCATE

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;

TRUNCATE TABLE staging.job_postings_flat;

-- can be used after deleting all rows
INSERT INTO staging.job_postings_flat
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name,
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_posted_date >= '2024-01-01';

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;