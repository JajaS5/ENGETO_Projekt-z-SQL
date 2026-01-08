-- mzdy-potraviny-Ceska republika--

DROP TABLE IF EXISTS t_jana_sitova_project_SQL_primary_final;

CREATE TABLE t_jana_sitova_project_SQL_primary_final AS 
SELECT
             czpay.payroll_year AS year,
             czpay.industry_branch_code AS id_branch,
             indbra.name AS branch,
             ROUND (AVG (czpay.value),2) AS avg_payroll,
             price.category_code AS id_goods,
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
GROUP BY year, id_branch, branch, id_goods, goods
ORDER BY year, id_branch, id_goods
;



