-- 02_data_cleaning.sql
-- Nettoyage dataset pour Q3

-- Question 3 diagnostic : on voit continents/regions dans location
select distinct
    location,
    continent,
    population
from covid_analysis
where continent is null
order by population DESC;

-- On voit que dans la colonne location (pays), on a des continents (Africa, Asia, Europe, etc) 
-- et des régions par revenus (High income, Low income, etc)
-- on va essayer d'identifier les pays ayant des valeurs high income, middle income, low income dans la colonne location

select count(*)
from covid_analysis
where location like '%income%';
-- Il y a 11'746 lignes avec des valeurs income dans la colonne location

-- Je vais créer une nouvelle colonne income_group 
ALTER TABLE covid_analysis
add column income_group VARCHAR(50);

-- remplir la colonne income_group avec les données de la colonne location high income, low income.
update covid_analysis
set income_group = location
where location like '%income%';

-- Je vérifie que la colonne income_group est bien remplie avec les valeurs high income, low income.
select distinct income_group
from covid_analysis;

-- je vais supprimer les lignes avec des valeurs income dans la colonne location
delete from covid_analysis
where location like '%income%';

-- Je vérifie que les lignes ont bien été supprimées
select distinct(location)
from covid_analysis
where location like '%income%';
-- Il n'y a plus de lignes avec des valeurs income dans la colonne location

-- Avant de répondre à la question 3, je vais vérifier s'il y a d'autres valeurs non pays dans la colonne location
SELECT DISTINCT
    location,
    population
from covid_analysis
order by population DESC;

-- Je vois qu'il y a des valeurs comme World, Asia, Europe, Africa, etc.
-- je vais les transférer dans la colonne continent
update covid_analysis
set continent = location
where location in ('World', 'Asia', 'Europe', 'Africa', 'North America', 'South America', 'Oceania');

-- Je vérifie que les lignes ont bien été transférées
select distinct continent
from covid_analysis
where continent in ('World', 'Asia', 'Europe', 'Africa', 'North America', 'South America', 'Oceania', 'European Union (27)');

-- je vais supprimer les lignes avec des valeurs World, Asia, Europe, Africa, North America, South America, European Union (27) , Oceania dans la colonne location
delete from covid_analysis
where location in ('World', 'Asia', 'Europe', 'Africa', 'North America', 'South America', 'Oceania', 'European Union (27)');


-- je veux renommer la colonne location en country pour plus de clarté
alter table covid_analysis
rename column location to country;