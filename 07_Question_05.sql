--5Q--Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?--

--meziroční % změny mezd a cen potravin--
CREATE OR REPLACE VIEW v_price_payroll_changes AS
WITH changes AS (
           SELECT
                          year,
                         avg_payroll_year,
                         avg_price_year,
                         LAG(avg_payroll_year) OVER (ORDER BY year) AS prev_payroll,
                         LAG(avg_price_year) OVER (ORDER BY year) AS prev_price
             FROM t_jasi_yearly_values)
            SELECT
                         year,
                       ROUND(((avg_payroll_year - prev_payroll) / prev_payroll) * 100, 2) AS payroll_growth_pct,
                       ROUND(((avg_price_year - prev_price) / prev_price) * 100, 2) AS food_price_growth_pct
                      FROM changes
                      WHERE prev_payroll IS NOT NULL;

--CHECK--
SELECT *
FROM v_price_payroll_changes;

--
