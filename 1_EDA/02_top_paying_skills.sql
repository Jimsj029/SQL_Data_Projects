/*
Question: What are the highest-paying skills for data engineers in the Philippines?
- Calculate the median salary for each skill required in data engineer positions
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/


SELECT
    -- Display the skill name instead of its ID for readability.
    sd.skills,

    -- Median salary 
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,

    -- Count how many job postings require each skill.
    COUNT(jpf.*) AS demand_count

FROM job_postings_fact AS jpf

-- Bridge table connecting jobs and skills.
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

-- Retrieve the skill names from the dimension table.
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

-- Filter to only remote Data Engineer positions in the Philippines before aggregation.
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'Philippines'

-- Group rows by skill so each count represents one skill.
GROUP BY
    sd.skills

HAVING 
    COUNT(jpf.*) > 100

-- Show the most requested skills first.
ORDER BY
    median_salary DESC
LIMIT 10;


/*

Here's the breakdown of the highest-paying skills for Data Engineers in the Philippines:
Flow and Unix offer the highest median salaries, both exceeding $140,000, although they appear in relatively fewer job postings.
Kubernetes and SSIS also command high median salaries, combining strong compensation with moderate demand.
Java stands out by offering a competitive median salary while appearing in the highest number of job postings among the top-paying skills.

Key Takeaways:
- Flow and Unix offer the highest median salaries but have lower demand than other top-paying skills.
- Kubernetes and SSIS provide a strong balance between high salary and market demand.
- Java combines competitive pay with the highest demand, making it one of the most valuable skills to learn.
- PostgreSQL, BigQuery, JavaScript, PHP, and R also offer strong salaries, expanding the range of high-value technical skills.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ flow       │      147500.0 │          238 │
│ unix       │      140000.0 │          214 │
│ kubernetes │      114177.0 │          137 │
│ ssis       │      114177.0 │          306 │
│ r          │       97444.0 │          270 │
│ java       │       96773.0 │          737 │
│ php        │       96773.0 │          146 │
│ postgresql │       96773.0 │          223 │
│ bigquery   │       96773.0 │          235 │
│ javascript │       96250.0 │          180 │
└────────────┴───────────────┴──────────────┘
*/


SELECT
    -- Display the skill name instead of its ID for readability.
    sd.skills,

    -- Median salary 
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,

    -- Count how many job postings require each skill.
    COUNT(jpf.*) AS demand_count

FROM job_postings_fact AS jpf

-- Bridge table connecting jobs and skills.
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

-- Retrieve the skill names from the dimension table.
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

-- Filter to only remote Data Engineer positions in the Philippines before aggregation.
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'Philippines'
    AND jpf.job_work_from_home = True 

-- Group rows by skill so each count represents one skill.
GROUP BY
    sd.skills

HAVING 
    COUNT(jpf.*) > 100

-- Show the most requested skills first.
ORDER BY
    median_salary DESC
LIMIT 100;

/*


Here's the breakdown of the highest-paying skills for remote Data Engineers in the Philippines:
SQL, Python, Azure, and AWS are the most frequently requested skills in remote job postings.
However, the dataset contains insufficient salary information for these roles, resulting in NULL median salaries for all high-demand skills.

Key Takeaways:
- SQL, Python, Azure, and AWS remain the most in-demand skills for remote Data Engineer roles.
- Salary comparisons cannot be performed reliably due to the limited salary data available for these postings.
- These results are useful for analyzing skill demand, but additional salary data is needed for meaningful compensation analysis.


┌──────────┬───────────────┬──────────────┐
│  skills  │ median_salary │ demand_count │
│ varchar  │    double     │    int64     │
├──────────┼───────────────┼──────────────┤
│ aws      │          NULL │          221 │
│ sql      │          NULL │          439 │
│ python   │          NULL │          371 │
│ spark    │          NULL │          117 │
│ azure    │          NULL │          304 │
│ power bi │          NULL │          151 │
│ excel    │          NULL │          116 │
└──────────┴───────────────┴──────────────┘

*/


