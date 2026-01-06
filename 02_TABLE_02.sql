--Ekonomicka data-Evropa--

DROP TABLE IF EXISTS t_jana_sitova_project_sql_secondary_final;

CREATE TABLE t_jana_sitova_project_sql_secondary_final AS
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

