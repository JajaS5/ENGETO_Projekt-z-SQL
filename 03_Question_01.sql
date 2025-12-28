--Q1 - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?--

--Porovnání mezd za první 2006) a poslední (2018) srovnatelné období--
SELECT
              br_name,
              ROUND(MAX(CASE WHEN yr_pay = 2006 THEN avg_payroll END), 2) AS payroll_2006,
              ROUND(MAX(CASE WHEN yr_pay = 2018 THEN avg_payroll END), 2) AS payroll_2018,
              ROUND((MAX(CASE WHEN yr_pay = 2018 THEN avg_payroll END)- MAX(CASE WHEN yr_pay = 2006 THEN avg_payroll END))/ 
              NULLIF(MAX(CASE WHEN yr_pay = 2006 THEN avg_payroll END), 0) *100,2) AS payroll_change_percent
FROM t_jana_sitova_project_sql_primary_final
WHERE yr_pay IN (2006, 2018)
GROUP BY br_name
ORDER BY payroll_change_percent;
