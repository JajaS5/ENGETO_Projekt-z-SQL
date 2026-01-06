--Pomocne SELECTY--

--TO TABLE-01--
--ZKOUSKA--
SELECT *
FROM t_jana_sitova_project_sql_primary_final;

--POMOCNE SELECTY--

--Zjistení min/max--

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

--TO TABLE_02--
--CHECK--

SELECT*
FROM t_jana_sitova_sql_primary_secondary_final;

--CHECK-duplicity, kazdý země=13 řádků (2006-2018)

SELECT country, COUNT(*) AS row_count
FROM t_jana_sitova_sql_primary_secondary_final
GROUP BY country
ORDER BY row_count DESC;

--


--Pocet 0 ve sloupecku--

SELECT COUNT(*) AS pocet_radku
FROM czechia_payroll
WHERE value_type_code = 5958
AND industry_branch_code IS NULL;
--output 172-- 
 
--overení UNIT CODE--
SELECT DISTINCT unit_code
FROM czechia_payroll
WHERE value_type_code = 5958;
--output 200--
--prumerna mzda--unit code=200--

