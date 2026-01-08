--pomocny SELECT--code mleko_chleb--
SELECT 
	cpc.name,
	cpc.code
FROM czechia_price_category cpc 
WHERE cpc.name LIKE 'Chléb%' OR cpc.name LIKE 'Mléko%'
;
--output--chleb 111301--mleko 114201--

---overeni nul--
SELECT COUNT(*) AS pocet_radku
FROM t_jana_sitova_project_SQL_primary_final
WHERE id_branch IS NULL;
