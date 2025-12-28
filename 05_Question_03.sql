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




