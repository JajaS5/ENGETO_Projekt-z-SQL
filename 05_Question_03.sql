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

---další--


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


