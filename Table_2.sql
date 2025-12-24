-- vytvorení DRUHÉ tabulky--

DROP TABLE IF EXISTS t_jana_sitova_sql_secondary_final;


CREATE TABLE t_jana_sitova_sql_primary_secondary_final AS 
SELECT
    cou.country,
    eco.year,
    eco.population,
    eco.gini,
    eco.gdp
FROM countries AS cou
INNER JOIN economies AS eco
    ON eco.country = cou.country
WHERE cou.continent = 'Europe'
  AND eco.year BETWEEN 2006 AND 2018
ORDER BY
    cou.country,
    eco.year;

--CHECK--
SELECT*
FROM t_jana_sitova_sql_primary_secondary_final;
