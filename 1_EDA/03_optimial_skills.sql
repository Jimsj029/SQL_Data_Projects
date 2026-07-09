/*

World Wide Remote Jobs, I tried filtering to Ph but not enough data 

Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/


SELECT
    -- Display the skill name for easier interpretation.
    sd.skills,

    -- Calculate the median salary to reduce the impact of salary outliers.
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,

    -- Count how many salary-reporting job postings require each skill.
    COUNT(jpf.salary_year_avg) AS demand_count,

    -- Apply a logarithmic scale to demand to reduce the influence of extremely common skills.
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,

    -- Combine salary and normalized demand into a single score for ranking skills.
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))) / 1_000_000, 2) AS optimal_score

FROM job_postings_fact AS jpf

-- Bridge table connecting job postings to their required skills.
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

-- Retrieve the descriptive skill names.
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

-- Limit the analysis to remote Data Engineer jobs with salary information.
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
    AND jpf.salary_year_avg IS NOT NULL

-- Aggregate results so each row represents one skill.
GROUP BY
    sd.skills

-- Exclude rarely requested skills to improve the reliability of the ranking.
HAVING
    COUNT(jpf.*) > 100

-- Rank skills by the combined salary and demand score.
ORDER BY
    optimal_score DESC

-- Return the top 20 most optimal skills.
LIMIT 20;

/*
Here's a breakdown of the most optimal skills for Data Engineers, balancing both market demand and median salary:

Top Skills by Optimal Score:
- Terraform ranks first, combining the highest median salary ($184K) with solid market demand (193 postings).
- Python and SQL offer the best balance of demand and compensation, each appearing in over 1,100 job postings while maintaining median salaries above $130K.
- AWS, Airflow, and Spark also rank highly, demonstrating strong demand alongside competitive salaries ranging from $137K to $150K.
- Kafka and Snowflake provide attractive salaries while maintaining moderate demand, making them valuable specialized skills.

Cloud & Data Engineering Technologies:
- AWS, Azure, Snowflake, Databricks, and Redshift highlight the continued importance of cloud platforms and cloud data warehousing.
- Airflow, Spark, Kafka, Hadoop, and Kubernetes reinforce the demand for modern data pipeline orchestration and big data processing tools.

Programming Languages:
- Python remains the strongest programming language due to its combination of high demand and competitive salary.
- SQL continues to be a foundational skill, while Java, Scala, Go, and R also offer strong earning potential.

Summary:
The strongest long-term skills combine high employer demand with competitive salaries rather than excelling in only one area. Python, SQL, AWS, Airflow, Spark, and Terraform stand out as the most strategic skills for Data Engineers seeking both career opportunities and higher compensation.

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │          193 │             5.3 │          0.98 │
│ python     │      135000.0 │         1133 │             7.0 │          0.95 │
│ aws        │      137320.3 │          783 │             6.7 │          0.92 │
│ sql        │      130000.0 │         1128 │             7.0 │          0.91 │
│ airflow    │      150000.0 │          386 │             6.0 │          0.90 │
│ spark      │      140000.0 │          503 │             6.2 │          0.87 │
│ kafka      │      145000.0 │          292 │             5.7 │          0.83 │
│ snowflake  │      135500.0 │          438 │             6.1 │          0.83 │
│ azure      │      128000.0 │          475 │             6.2 │          0.79 │
│ java       │      135000.0 │          303 │             5.7 │          0.77 │
│ scala      │      137290.5 │          247 │             5.5 │          0.76 │
│ kubernetes │      150500.0 │          147 │             5.0 │          0.75 │
│ databricks │      132750.0 │          266 │             5.6 │          0.74 │
│ git        │      140000.0 │          208 │             5.3 │          0.74 │
│ redshift   │      130000.0 │          274 │             5.6 │          0.73 │
│ gcp        │      136000.0 │          196 │             5.3 │          0.72 │
│ hadoop     │      135000.0 │          198 │             5.3 │          0.72 │
│ nosql      │      134415.0 │          193 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │          152 │             5.0 │          0.70 │
│ docker     │      135000.0 │          144 │             5.0 │          0.68 │
│ mongodb    │      135750.0 │          136 │             4.9 │          0.67 │
│ r          │      134775.0 │          133 │             4.9 │          0.66 │
│ go         │      140000.0 │          113 │             4.7 │          0.66 │
│ github     │      135000.0 │          127 │             4.8 │          0.65 │
│ bigquery   │      135000.0 │          123 │             4.8 │          0.65 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
*/