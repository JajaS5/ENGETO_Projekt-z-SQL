--Q1 - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?--

--Porovnání mezd za první 2006) a poslední (2018) srovnatelné období--
SELECT
              branch,
              ROUND(MAX(CASE WHEN year = 2006 THEN avg_payroll END), 2) AS payroll_2006,
              ROUND(MAX(CASE WHEN year = 2018 THEN avg_payroll END), 2) AS payroll_2018,
              ROUND((MAX(CASE WHEN year = 2018 THEN avg_payroll END)- MAX(CASE WHEN yr_pay = 2006 THEN avg_payroll END))/ 
              NULLIF(MAX(CASE WHEN year = 2006 THEN avg_payroll END), 0) *100,2) AS payroll_change_percent
FROM t_jana_sitova_project_sql_primary_final
WHERE year IN (2006, 2018)
GROUP BY branch
ORDER BY payroll_change_percent;

--Zjištění poklesu mezd, klesají mzdy????---
WITH yearly_payroll AS (
        SELECT
                    branch,
                    year,
                    AVG(avg_payroll) AS avg_payroll_year
         FROM t_jana_sitova_project_sql_primary_final
        WHERE year BETWEEN 2006 AND 2018
       GROUP BY branch, year),
payroll_changes AS (
         SELECT
                     brancg,
                     year,
                     avg_payroll_year,
                     LAG(avg_payroll_year) OVER (PARTITION BY branch ORDER BY year) AS prev_payroll
       FROM yearly_payroll
)
       SELECT
                   branch,
                   CASE
                            WHEN MIN(avg_payroll_year - prev_payroll) < 0 THEN 'ANO, někdy klesaly'
                            ELSE 'NE, pouze rostly' END AS payroll_trend
     FROM payroll_changes
    WHERE prev_payroll IS NOT NULL
    GROUP BY branch
    ORDER BY payroll_trend;

--Pokles mezd, meziroční pokles--
WITH yearly_payroll AS (
          SELECT
                   branch AS industry_branch,
                   year AS year,
                   AVG(avg_payroll) AS avg_payroll_year
                  FROM t_jana_sitova_project_sql_primary_final
           WHERE year BETWEEN 2006 AND 2018
           GROUP BY branch, year),
payroll_changes AS (
          SELECT
                   industry_branch,
                   year,
                   avg_payroll_year,
                   LAG(avg_payroll_year) OVER (PARTITION BY industry_branch ORDER BY year ) AS prev_payroll
          FROM yearly_payroll)
         SELECT
                  industry_branch,
                 year,
                ROUND(((avg_payroll_year - prev_payroll) / prev_payroll) * 100, 2) AS yoy_change_percent
               FROM payroll_changes
              WHERE prev_payroll IS NOT NULL
              AND avg_payroll_year < prev_payroll
              ORDER BY yoy_change_percent ASC;


