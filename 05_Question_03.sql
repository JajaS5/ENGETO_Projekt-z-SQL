--Q3-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?--

--Porovnaní ceny za první (2006) a poslední (2018) srovnatelene období--
SELECT
            goods,
            MAX(CASE WHEN yr_pay = 2006 THEN avg_price END) AS price_2006,
            MAX(CASE WHEN yr_pay = 2018 THEN avg_price END) AS price_2018,
            ROUND(
            (
            MAX(CASE WHEN yr_pay = 2018 THEN avg_price END)
            - MAX(CASE WHEN yr_pay = 2006 THEN avg_price END)
        )
        / NULLIF(MAX(CASE WHEN yr_pay = 2006 THEN avg_price END), 0) * 100,
        2
    ) AS price_diff_percent
FROM t_jana_sitova_project_sql_primary_final
WHERE yr_pay IN (2006, 2018)
GROUP BY goods
ORDER BY price_diff_percent DESC;

---Celkový průměr meziročních změn (pokles/růst) ceny potravin v %--
WITH yearly_prices AS (
           SELECT
                       goods,
                       yr_pay,
                       AVG(avg_price) AS avg_price_year
           FROM t_jana_sitova_project_sql_primary_final
          GROUP BY goods, yr_pay),
price_changes AS (
          SELECT
                      goods,
                      yr_pay,
                      avg_price_year,
                      LAG(avg_price_year) OVER (
                      PARTITION BY goods
                      ORDER BY yr_pay) AS prev_price
           FROM yearly_prices)
  SELECT
               goods,
                ROUND(AVG((avg_price_year - prev_price)/ NULLIF(prev_price, 0) * 100), 2) AS avg_yoy_growth_percent
FROM price_changes
WHERE prev_price IS NOT NULL
GROUP BY goods
ORDER BY avg_yoy_growth_percent ASC;






