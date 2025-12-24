-- vytvorení první tabulky--

DROP TABLE IF EXISTS t_jana_sitova_sql_primary_final;

CREATE TABLE t_jana_sitova_sql_primary_final AS 
SELECT
             czpay.payroll_year AS year,
             czpay.industry_branch_code AS ID_branch,
             indbra.name AS branch,
             ROUND (AVG (czpay.value),2) AS avg_payroll,
             price.category_code AS ID_goods,
             catpr.name AS goods,
             ROUND (AVG(price.value):: numeric,2) AS avg_price
FROM czechia_payroll czpay
LEFT JOIN czechia_payroll_industry_branch indbra
          ON czpay.industry_branch_code=indbra.code
 LEFT JOIN czechia_price price
           ON czpay.payroll_year=DATE_PART ('year', price.date_from)
 LEFT JOIN czechia_price_category catpr
           ON price.category_code=catpr.code
WHERE  czpay.industry_branch_code IS NOT  NULL
      AND czpay.payroll_year BETWEEN 2006 AND 2018
      AND czpay.value_type_code = 5958
      AND czpay.unit_code=200
      AND czpay.calculation_code=200
GROUP BY year, ID_branch, branch, ID_goods, goods
ORDER BY year, ID_branch, ID_goods
;

--ZKOUSKA--
SELECT *
FROM t_jana_sitova_sql_primary_final;

--POMOCNE SELECTY--

SELECT
      min (payroll_year), 
      max (payroll_year)
 FROM czechia_payroll;
--output 2000, 2021--

SELECT
      min (date_from),
      max (date_to)
FROM czechia_price;
--output 2006, 2018--

SELECT
     min (year),
     max (year)
FROM economies; 
--output 1960, 2020--



