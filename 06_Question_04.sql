--4Q -- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?--

--průměrná mzda v daném roce--průměrná cena v daném roce--
CREATE OR REPLACE VIEW t_jasi_yearly_values AS
SELECT
            yr_pay AS year,
            AVG(avg_payroll) AS avg_payroll_year,
           AVG(avg_price) AS avg_price_year
FROM t_jana_sitova_project_sql_primary_final
GROUP BY yr_pay
ORDER BY YEAR;

--mezroční růst price/payroll--rozdíl--
WITH yearly_growth AS (
           SELECT
                      year,
                      avg_payroll_year,
                      avg_price_year,
                      LAG(avg_payroll_year) OVER (ORDER BY year) AS prev_payroll,
                      LAG(avg_price_year) OVER (ORDER BY year) AS prev_price
           FROM t_jasi_yearly_values)
          SELECT
                     year,
                     ROUND(((avg_price_year - prev_price) / prev_price) * 100, 2) AS growth_price_percent,
                     ROUND(((avg_payroll_year - prev_payroll) / prev_payroll) * 100, 2) AS growth_payroll_percent,
    ROUND(
        ((avg_price_year - prev_price) / prev_price) * 100
        - ((avg_payroll_year - prev_payroll) / prev_payroll) * 100
    , 2) AS difference_percent
           FROM yearly_growth
          WHERE prev_payroll IS NOT NULL
           ORDER BY year;

