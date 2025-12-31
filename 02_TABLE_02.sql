-- vytvorení DRUHÉ tabulky--Ekonimicka data-Evropa--

DROP TABLE IF EXISTS t_jana_sitova_sql_secondary_final;

CREATE TABLE t_jana_sitova_sql_primary_secondary_final AS
               SELECT
                          cou.country,
                          eco.year,
                          AVG(eco.population) AS population,
                         AVG(eco.gini) AS gini,
                         AVG(eco.gdp) AS gdp
                FROM countries AS cou
JOIN economies AS eco
               ON eco.country = cou.country
               WHERE cou.continent = 'Europe'
               AND eco.year BETWEEN 2006 AND 2018
              GROUP BY cou.country, eco.year
              ORDER BY cou.country, eco.year;

--CHECK--

SELECT*
FROM t_jana_sitova_sql_primary_secondary_final;

--CHECK-duplicity, kazdý země=13 řádků (2006-2018)

SELECT country, COUNT(*) AS row_count
FROM t_jana_sitova_sql_primary_secondary_final
GROUP BY country
ORDER BY row_count DESC;

--
