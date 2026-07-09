/*
Exercise 1: Company Names
Scanerio: The hiring manager wants to know which companies are hiring.

Task

Return:

Job ID
Job title
Company name
Job location

*/

SELECT 
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location,
    cd.name AS company_name
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT * FROM job_postings_fact LIMIT 10;

SELECT * FROM company_dim LIMIT 10;

-- MAKE SURE TO CHECK THE Primary & FOREIGN KEY OF EACH TABLE. QUERY THEM FIRST!!!!


/*
Exercise 2: Count Skills Per Job
Scanerio: Recruiters want to know how many skills are listed for each job posting.

Task

Return:

Job ID
Job title
Number of required skills

Requirements:

Use a LEFT JOIN
Group by the job
Sort from the most skills to the fewest

*/

SELECT 
    jpf.job_id,
    jpf.job_title_short,
    COUNT(sjd.skill_id) AS num_skills
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
GROUP BY
    jpf.job_id,
    jpf.job_title_short
ORDER BY
    num_skills DESC
LIMIT 10;

SELECT * FROM skills_job_dim LIMIT 10;


/*
Exercise 3 : Skills Used Most Often
Scanerio: Which skills appear in the largest number of job postings?

Task

Return:

Skill name
Number of job postings requiring that skill

Requirements:

Join the necessary tables
Group by the skill
Sort by the number of postings (highest first)

*/

SELECT 
    sd.skills AS skill,
    COUNT(jpf.job_id) AS num_jobs
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sd.skill_id = sjd.skill_id
GROUP BY
    skill
ORDER BY
    num_jobs DESC
LIMIT 10;

SELECT * FROM skills_job_dim LIMIT 10;
SELECT * FROM skills_dim LIMIT 10;|


/*
Exercise 4 : 
Scanerio: Find the top 10 companies for postings jobs. They must have 
          >3000 postings AND LIMIT ONLY TO US jobs

*/

SELECT
    cd.name AS company_name,
    jpf.job_country AS country,
    COUNT(jpf.job_id) AS postings
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY
    cd.name,
    job_country
HAVING
    COUNT(*) > 3000 
ORDER BY
    postings DESC
LIMIT 10;

SELECT job_country FROM job_postings_fact LIMIT 10;