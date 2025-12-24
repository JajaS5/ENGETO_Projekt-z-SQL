-- Q2 -- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?--

--pomocny SELECT--code mleko_chleb--
SELECT 
	cpc.name,
	cpc.code
FROM czechia_price_category cpc 
WHERE cpc.name LIKE 'Chléb%' OR cpc.name LIKE 'Mléko%'
;
--chleb 111301--mleko 114201--

---overeni nul--
SELECT COUNT(*) AS pocet_radku
FROM t_jana_sitova_project_sql_primary_final
WHERE id_branch IS NULL;

--SELECT Q2--
WITH jasi AS (
    SELECT 
        tjasif.YEAR, 
        tjasif.id_goods,
        tjasif.goods, 
        ROUND(AVG(tjasif.avg_payroll), 2) AS avg_of_avg_payroll,
        ROUND(AVG(tjasif.avg_price), 2) AS avg_of_avg_price,
        cpca.price_value,
        cpca.price_unit
    FROM t_jana_sitova_sql_primary_final tjasif
    JOIN czechia_price_category cpca
              ON tjasif.id_goods = cpca.code
    WHERE tjasif.YEAR IN (2006, 2018)
                 AND tjasif.id_goods IN (111301, 114201)
    GROUP BY 
        tjasif.YEAR,
        tjasif.id_goods,
        tjasif.goods,
        cpca.price_value,
        cpca.price_unit
)
SELECT *,
       ROUND(avg_of_avg_payroll / avg_of_avg_price, 2) AS purchasing_power
FROM jasi
ORDER BY YEAR;




