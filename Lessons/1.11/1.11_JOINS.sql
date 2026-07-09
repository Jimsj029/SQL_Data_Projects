

-- LEFT JOIN

SELECT                           -- COLUMNS
    jpf.job_id,                  -- jpf = from job_postings_fact
    jpf.job_title_short,
    cd.name AS company_name,     -- cd = company_dim
    jpf.job_location
FROM
    job_postings_fact AS jpf    -- Table A
LEFT JOIN company_dim AS cd     -- Table B
    -- Match rows where company id are the same
    ON jpf.company_id = cd.company_id 
LIMIT 10;



-- INNER JOIN

SELECT                           -- COLUMNS
    jpf.job_id,                  -- jpf = from job_postings_fact
    jpf.job_title_short,
    cd.name AS company_name,     -- cd = company_dim
    jpf.job_location
FROM
    job_postings_fact AS jpf    -- Table A
INNER JOIN company_dim AS cd     -- Table B
    -- Match rows where company id are the same
    ON jpf.company_id = cd.company_id 
LIMIT 10;


-- INNER JOIN

SELECT                           -- COLUMNS
    jpf.job_id,                  -- jpf = from job_postings_fact
    jpf.job_title_short,
    cd.name AS company_name,     -- cd = company_dim
    jpf.job_location
FROM
    job_postings_fact AS jpf    -- Table A
FULL OUTER JOIN company_dim AS cd     -- Table B
    -- Match rows where company id are the same
    ON jpf.company_id = cd.company_id 
LIMIT 10;


-- Three Table Example

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM job_postings_fact AS jpf      -- Contains the job_id/title_short
LEFT JOIN skills_job_dim AS sjd    -- This is a bridge table
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
LIMIT 10;


/*
Exercise 1: Company Names
Scanerio: The hiring manager wants to know which companies are hiring.

*/