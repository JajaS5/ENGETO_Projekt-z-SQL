--Q3-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?--

WITH price_changes AS (
         SELECT
                goods,
                yr_pay,
               avg_price,
               LAG(avg_price) OVER (
            PARTITION BY goods ORDER BY yr_pay) AS prev_price
    FROM t_jana_sitova_project_sql_primary_final
)
SELECT
            goods,
            yr_pay AS year,
           prev_price,
          avg_price,
          ROUND(((avg_price - prev_price) / prev_price) * 100, 2) AS yoy_growth_percent
FROM price_changes
WHERE prev_price IS NOT NULL
ORDER BY yoy_growth_percent ASC, goods, year;


