-- 03_analyses_business.sql

-- Question 1 : Combien de pays différent dans le dataset
SELECT count(distinct country) as country_count
from covid_analysis;
-- Réponse : 217 pays différents

-- Question 2 : Combien de pays par continent
select
    continent,
    count(distinct country) as country_count
from covid_analysis
where continent is not null
group by continent
order by country_count desc;
-- Réponse : le pays avec le plus de pays est l'Afrique avec 59 pays

-- Question 3 : Quels sont les 10 pays les plus peuplés dans le dataset

select distinct
    country,
    population
from covid_analysis
order by population DESC
limit 10;
-- Réponse : Les 10 pays les plus peuplés sont :
-- 1. China 2. India 3. United States 4. Indonesia 5. Pakistan 6. Nigeria 7. Brazil 8. Bangladesh 9. Russia 10. Mexico


-- Question 4 : Quelle est la population total par continent
select
    continent,
    sum(population_par_pays) as population_totale
from (
    select distinct
        continent,
        country,
        population as population_par_pays
    from covid_analysis
    where population is not null
) as pays_uniques
GROUP BY continent
order by population_totale DESC;


-- Question 5 : Quels sont les pays avec le plus de cas cumulés
select
    country,
    max(total_cases) as total_cases_cumules
from covid_analysis
where total_cases is not null
group by
    country
order by total_cases_cumules desc
limit 10;


-- Question 6 : Quel est le taux de mortalité (% décès / cas confirmés) par continent

SELECT
    continent,
    SUM(total_deaths) AS total_deaths,                    -- Total des décès par continent
    SUM(total_cases) AS total_cases,                      -- Total des cas confirmés par continent
    ROUND(
        (SUM(total_deaths) * 100.0 / NULLIF(SUM(total_cases), 0))::NUMERIC,  -- ::NUMERIC = cast en type numérique pour ROUND() PostgreSQL
        2
    ) AS taux_mortalite_pourcent                          -- Résultat en % avec 2 décimales
FROM covid_analysis
WHERE total_deaths IS NOT NULL                          -- Exclut les lignes sans décès
  AND total_cases IS NOT NULL                           -- Exclut les lignes sans cas
GROUP BY continent                                     
ORDER BY continent;                                    



-- Question 7 : Quels pays ont la plus grande part de population infectée (cas confirmés / population) en date la plus récente.

SELECT
    country,
    date_derniere,
    total_cases,
    part_population_infectee_pct
FROM (
    SELECT DISTINCT ON (country)
        date as date_derniere,
        country,
        total_cases,
        ROUND(
            (total_cases * 100.0 / NULLIF(population, 0))::NUMERIC, -- ::NUMERIC = cast en type numérique pour ROUND() PostgreSQL
            2
        ) AS part_population_infectee_pct
    FROM covid_analysis
    WHERE total_cases IS NOT NULL
      AND population IS NOT NULL
    ORDER BY country, date DESC  -- Prend la DERNIÈRE date par pays
) AS derniere_date_par_pays
ORDER BY part_population_infectee_pct DESC
LIMIT 10;


-- Question 8 : Quels pays ont la plus grande part de population décédée (décès / population)

SELECT 
    country,
    date_derniere,
    part_population_decedee
FROM
(
    SELECT distinct on (country)
    date as date_derniere,
    country,
    round(
        (total_deaths * 100.0 / nullif(population,0))::NUMERIC,
        2) as part_population_decedee
from covid_analysis
where total_deaths is not NULL
    and population is not NULL
order by 
    country, date DESC
) as sous_requete_part_population_decedee
ORDER BY
    part_population_decedee DESC
LIMIT 10;