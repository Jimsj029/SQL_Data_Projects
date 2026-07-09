/*
Question: What are the top 10 most in-demand skills for data engineers in the Philipines?
- Combination of WFH and On-site
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT
    -- Display the skill name instead of its ID for readability.
    sd.skills,

    -- Count how many job postings in jpf table require each skill.
    COUNT(jpf.*) AS demand_count

FROM job_postings_fact AS jpf 

-- Bridge table connecting jobs and skills.
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

-- Retrieve the skill names from the table.
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

-- Filter to Philippines and Data Engineer positions.
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND job_country = 'Philippines'

-- Group rows by skill so each count represents one skill.
GROUP BY
    sd.skills

-- Show the most requested skills first.
ORDER BY
    demand_count DESC

-- Return only the top 10 skills.
LIMIT 10;

/*

Here's the breakdown of the most demanded skills for Data Engineers in the Philippines (On-site/WFH):
SQL and Python are the two most requested skills, with SQL appearing in nearly 2,900 job postings and Python in over 2,400.
Cloud platforms follow closely, with Azure leading AWS, reflecting the growing demand for cloud-based data engineering.
Big data technologies such as Spark, Databricks, Hadoop, and Snowflake also rank among the top skills, emphasizing the need for scalable data processing expertise.

Key Takeaways:
- SQL and Python remain the foundational skills for Data Engineers.
- Azure and AWS are the leading cloud platforms sought by employers.
- Spark, Databricks, Hadoop, and Snowflake highlight the importance of big data and cloud data warehousing.
- Java and Power BI are also commonly requested, showing the value of programming and reporting skills.


┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │         2870 │
│ python     │         2403 │
│ azure      │         1535 │
│ aws        │         1235 │
│ spark      │          860 │
│ java       │          737 │
│ power bi   │          637 │
│ databricks │          636 │
│ hadoop     │          594 │
│ snowflake  │          544 │
└────────────┴──────────────┘
*/


/*
Question: What are the top 10 most in-demand skills for data engineers in the Philipines?
- Focus on WORK-FROM-HOME jobs
*/
SELECT
    -- Display the skill name instead of its ID for readability.
    sd.skills,

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

-- Show the most requested skills first.
ORDER BY
    demand_count DESC
LIMIT 10;

/*

Here's the breakdown of the most demanded skills for remote Data Engineers in the Philippines:
SQL and Python remain the most requested skills, with SQL appearing in over 400 job postings and Python in more than 370.
Azure and AWS are the top cloud platforms, highlighting the continued demand for cloud engineering skills in remote roles.
Power BI, Spark, Databricks, and Terraform also rank in the top 10, showing that analytics, big data, 
and infrastructure technologies are important for remote data engineering positions.

Key Takeaways:
- SQL and Python remain the foundational skills for remote Data Engineers.
- Azure and AWS are the most sought-after cloud platforms.
- Power BI and Excel indicate that reporting and data analysis skills are valuable.
- Spark, Databricks, and Terraform demonstrate the demand for big data processing and cloud infrastructure expertise.

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │          439 │
│ python     │          371 │
│ azure      │          304 │
│ aws        │          221 │
│ power bi   │          151 │
│ spark      │          117 │
│ excel      │          116 │
│ java       │           87 │
│ databricks │           85 │
│ terraform  │           76 │
└────────────┴──────────────┘

*/





