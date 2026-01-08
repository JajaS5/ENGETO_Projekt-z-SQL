# PROJEKT z SQL

Projekt z SQL byl vytvořen v rámci kurzu Datové Akademie.  

## Cíl projektu
Cílem projektu je nalézt odpovědi na následující výzkumné otázky:

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %) ?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin?  
   Neboli: pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

---

## Datový základ

Z poskytnutých dat byly vytvořeny dvě tabulky:

| Název tabulky | Popis | Soubor |
|---------------|-------|--------|
| `t_jana_sitova_project_SQL_primary_final` | Data mezd a cen potravin v ČR | `01_TABLE_01.sql` |
| `t_jana_sitova_project_SQL_secondary_final` | Ekonomická data evropských států | `01_TABLE_02.sql` |

Data zahrnují období **2006–2018**.  
První tabulka obsahuje data mezd a cen potravin v ČR.  
Druhá tabulka zahrnuje ekonomická data evropských států.  

---

## Analytická část

Na základě uvedených dat byly vytvořeny SQL dotazy v souborech `03` až `07`, které odpovídají na výzkumné otázky.  
Podrobný popis a interpretaci výsledků poskytuje samostatný soubor:

📄 `08_Answers.md`

---

**Autor:**  
*Ing. Jana Sitová*
