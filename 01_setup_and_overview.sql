-- 01_setup_and_overview.sql
-- Objectif : repartir d'une table d'analyse propre à partir des données brutes
-- et vérifier que les tables et le volume de données sont corrects.

-- Étape 0a : Réinitialiser la table d'analyse
-- On supprime covid_analysis si elle existe déjà, pour repartir de zéro.
DROP TABLE IF EXISTS covid_analysis;

-- On recrée covid_analysis en copiant toutes les colonnes et lignes de covid_raw (données brutes).
CREATE TABLE covid_analysis AS
SELECT *
FROM covid_raw;

-- Étape 0b : Vérifier les tables de travail
-- On contrôle que les deux tables nécessaires au projet existent bien dans le schéma public.
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('covid_raw', 'covid_analysis')
ORDER BY table_name;

-- Étape 0c : Vue globale du volume de données
-- On vérifie le nombre total de lignes, le nombre de pays distincts
-- et la période couverte par les données dans covid_analysis.
SELECT
    COUNT(*) AS lignes,                  -- nombre total de lignes dans covid_analysis
    COUNT(DISTINCT location) AS nb_pays, -- nombre de pays / locations distincts
    MIN(date) AS premiere_date,          -- première date disponible
    MAX(date) AS derniere_date           -- dernière date disponible
FROM covid_analysis;
