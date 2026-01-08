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


--Meziroční % změna GDP za ČR--
CREATE OR REPLACE VIEW v_gdp_changes AS
WITH avg_gdp AS (
    SELECT
              year,
             gdp AS gdp_year
    FROM t_jana_sitova_project_SQL_secondary_final
    WHERE country = 'Czech Republic'),
changes AS (
    SELECT
             year,
            gdp_year,
           LAG(gdp_year) OVER (ORDER BY year) AS prev_gdp
  FROM avg_gdp)
  SELECT
           year,
          ROUND(
        ((gdp_year - prev_gdp) / NULLIF(prev_gdp, 0) * 100)::numeric,2) AS gdp_growth_pct
FROM changes
WHERE prev_gdp IS NOT NULL;

--meziroční % změny HDP, mezd a cen potravin--
SELECT
    p.year,
    g.gdp_growth_pct,
    p.payroll_growth_pct,
    p.food_price_growth_pct
FROM v_price_payroll_changes p
JOIN v_gdp_changes g USING (year)
ORDER BY p.year;

