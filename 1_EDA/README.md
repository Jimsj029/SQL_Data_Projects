# Exploratory Data Analysis w/ SQL: Job Market Analysis Philippines 

![PROJECT 1 OVERVIEW](../images/1_1_Project1_EDA.png)

A simple SQL project analyzing the data engineer job in the Philippines using real world job posting data. **It demonstrates my ability to write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights**.

# 📌 Executive Summary (For Hiring Managers)

### 🚀 Project Highlights

- ✅ Project Scope: Built SQL analyses to answer key business questions about the Data Engineer job market in the Philippines.  
- ✅ Data Modeling: Queried a star schema data warehouse using multi-table joins across fact and dimension tables.  
- ✅ Analytics: Applied filtering, aggregations, grouping, and ranking to identify the most in-demand, highest-paying, and most valuable technical skills.  
- ✅ Business Insights: Produced actionable findings on skill demand, salary trends, cloud technology adoption, and data quality limitations.  

### 📂 Quick Navigation

**If you're short on time, start with these SQL scripts:**

1️⃣ [`01_top_demanded_skills.sql`](01_top_demanded_skills.sql) – Identifies the most frequently requested skills for Data Engineers through demand analysis using multi-table joins.

2️⃣ [`02_top_paying_skills.sql`](02_top_paying_skills.sql) – Calculates median salaries for each skill to determine which technologies command the highest compensation.

3️⃣ [`03_optimial_skills.sql`](03_optimial_skills.sql) – Combines market demand and salary into a custom Optimal Score to identify the best skills for career growth.  

# ❓ Problem & Context

Job market analysts often need to answer questions such as:

- 🎯 Most In-Demand: Which skills are most requested for Data Engineer positions?  
- 💰 Highest Paying: Which technical skills command the highest salaries?  
- ⚖️ Best Trade-off: Which skills provide the best balance between demand and compensation?  

To answer these questions, this project analyzes a job postings data warehouse designed using a star schema, consisting of one fact table and multiple dimension tables.

![PROJECT 1 OVERVIEW](../images\1_2_Data_Warehouse.png)

# 🛠️ Tech Stack

                 
- 🐤 Query Engine: DuckDB for fast OLAP-style analytical queries
- 🧮 Language: SQL (ANSI-style with analytical functions)
- 📊 Data Model: Star schema with fact + dimension + bridge tables
- 🛠️ Development: VS Code for SQL editing + Terminal for DuckDB CLI
- 📦 Version Control: Git/GitHub for versioned SQL scripts

# 📂 Repository Structure

```
1_EDA/
├── 01_top_demanded_skills.sql    # Demand analysis query
├── 02_top_paying_skills.sql      # Salary analysis query
├── 03_optimal_skills.sql         # Combined demand/salary optimization
└── README.md                     # You are here
```

# 🔍 Analysis Overview

### Query Structure

- 📈 [`Most In-Demand Skills`](01_top_demanded_skills.sql) - Identifies the most requested technical skills for Data Engineer positions, with separate analyses for global remote jobs and the Philippine job market.
- 💰 [`Highest-Paying Skills`](02_top_paying_skills.sql)- Calculates the median salary for each skill to determine which technologies offer the highest compensation.
- ⚖️ [`Most Optimal Skills`](1_EDA\03_optimial_skills.sql) - Combines salary and market demand into a custom Optimal Score using the natural logarithm of demand to identify the most valuable skills for career growth.

# 💻 SQL Skills Demonstrated

### Query Design & Optimization

- **Complex Joins**: Used `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim` to connect job postings with their required skills.
- **Aggregations**: Applied `COUNT()`, `MEDIAN()`, `ROUND()`, and `LN()` to summarize demand, salaries, adn derived metrics.
- **Filtering**: Utilized `WHERE` clauses with multiple conditions to analyze specific job titles, location, remote roles, and salary-reported postings.
- **Sorting & Limiting**: Ranked results using `ORDER BY` and `LIMIT` to identify the highest-demand and highest-value skills.

### Data Analysis Techniques

- **Grouping**: Used `GROUP BY` to aggragate job postings by individual skills.
- **Mathematical Functions**: `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics**: Created a custom *Optimal Score* that combines salary and normalized demand into a single ranking metric.
- **HAVING clause**: Filtered aggregated results to include only skills with sufficient job posting volume for reliable analysis.
- **NULL handling**: Proper filtering of incomplete records `salary_year_avg IS NOT NULL`
