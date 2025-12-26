-- 04_time_series_analysis.sql

-- Question 1 : Évolution totale des cas confirmés par mois

SELECT
    to_char(date, 'yyyy-mm') as period_month,
    sum(new_cases) as total_new_cases
FROM covid_analysis
group by period_month
order by period_month;


-- Question 2 : Évolution des nouveaux cas par semaine (différence)

SELECT
    to_char(date, 'IYYY-IW') as period_week,
    sum(new_cases) as total_new_cases
FROM covid_analysis
group by period_week;

select
    date_trunc('week', date) as period_week,
    sum(new_cases) as total_new_cases_week,
    lag(sum(new_cases)) over (order by date_trunc('week', date)) as previous_week_cases, -- Fonction window qui récupère la valeur de la ligne précédente
    sum(new_cases) - lag(sum(new_cases)) over(order by date_trunc('week', date)) as difference_from_previous_week -- Calcul de la différence avec la semaine précédente
from 
    covid_analysis
group BY
    period_week
order by
    period_week;

-- Question 3 : Mois avec le plus de nouveaux cas

SELECT
    date_trunc('month', date) as period_month,
    sum(new_cases) as total_new_cases_month
from covid_analysis
group by period_month
order by total_new_cases_month desc
limit 1;

-- Question 4 : Croissance hebdomadaire des cas (variation %)
SELECT
    date_trunc('week', date) as period_week,
    SUM(new_cases) as total_new_cases_week,
    LAG(SUM(new_cases)) OVER (ORDER BY date_trunc('week', date)) as previous_week_cases,
    ROUND(
        (((SUM(new_cases) - LAG(SUM(new_cases)) OVER (ORDER BY date_trunc('week', date)))::NUMERIC -- Calcul de la différence avec la semaine précédente & conversion en numérique pour l'arrondi
        / NULLIF(LAG(SUM(new_cases)) OVER (ORDER BY date_trunc('week', date)), 0)) * 100)::NUMERIC, -- calcul du pourcentage & conversion en numérique pour l'arrondi
        2
    ) AS growth_rate_percent
FROM
    covid_analysis
GROUP BY date_trunc('week', date)
ORDER BY period_week;


-- Question 5 : Durée moyenne entre premier et dernier cas par pays (top 10)
SELECT
    country,
    MIN(date) as first_case_date,
    MAX(date) as last_case_date,
    MAX(date) - MIN(date) as duration_days
FROM covid_analysis
GROUP BY country
ORDER BY duration_days DESC
LIMIT 10;


-- Question 6 : Période avec le plus de décès par continent
SELECT
    continent,
    date_trunc('month', date) as period_month,
    sum(new_deaths) as total_new_deaths_month
from covid_analysis
group by 
    continent,
    date_trunc('month', date)
ORDER BY
    total_new_deaths_month DESC;

-- Question 7 : Évolution du taux de mortalité mensuel global

select
    date_trunc('month', date) as period_month,
    sum(total_deaths) as total_deaths_month,
    sum(total_cases) as total_cases_month,
    round(
        (sum(total_deaths) * 100.0 / nullif(sum(total_cases), 0))::NUMERIC,
        2
    ) as mortality_rate_per_month
from covid_analysis
group by date_trunc('month', date)
order by period_month;

-- Question 8 : Pays avec la croissance la plus rapide des cas (top 5)

SELECT  
    country,
    sum(new_cases) as total_new_cases,
    min(total_cases) as initial_total_cases,
    max(total_cases) as final_total_cases,
    round(
        ((max(total_cases)-min(total_cases))::numeric
        / nullif(min(total_cases), 0) * 100)::numeric,
        2
    ) as growth_rate_percent
from covid_analysis
where total_cases > 0
group by country
order by growth_rate_percent desc
limit 5;


-- Question 9 : Semaines records de nouveaux cas par continent

WITH weekly_totals AS (
    SELECT
        continent,
        date_trunc('week', date) as period_week,
        sum(new_cases) as total_new_cases_week,
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY sum(new_cases) DESC) as rang
    FROM covid_analysis
    WHERE continent IS NOT NULL
    GROUP BY continent, date_trunc('week', date)
)
SELECT
    continent,
    period_week,
    total_new_cases_week
FROM weekly_totals
WHERE rang = 1
ORDER BY total_new_cases_week DESC;



