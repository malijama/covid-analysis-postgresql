# Structure de la Base de Données COVID-19

## Vue d'Ensemble

Ce document décrit la structure des tables utilisées dans le projet d'analyse COVID-19.

**Important** : Les noms de colonnes et les données sont en **anglais** (format international de Our World in Data). Les commentaires et analyses SQL sont en français.

## Tables

### Table : `covid_raw`

Table contenant les données brutes importées depuis la source externe.

**Note** : Cette table n'est jamais modifiée. Elle sert de source de vérité pour régénérer `covid_analysis` si nécessaire.

### Table : `covid_analysis`

Table de travail créée à partir de `covid_raw` et nettoyée pour l'analyse.

#### Schéma

| Colonne | Type | Nullable | Description |
|---------|------|----------|-------------|
| `date` | DATE | Non | Date de l'enregistrement |
| `country` | VARCHAR | Oui | Nom du pays (renommé depuis `location`) |
| `continent` | VARCHAR | Oui | Nom du continent (Africa, Asia, Europe, etc.) |
| `population` | NUMERIC | Oui | Population totale du pays |
| `total_cases` | NUMERIC | Oui | Nombre total cumulé de cas confirmés |
| `new_cases` | NUMERIC | Oui | Nouveaux cas confirmés pour cette date |
| `total_deaths` | NUMERIC | Oui | Nombre total cumulé de décès |
| `new_deaths` | NUMERIC | Oui | Nouveaux décès pour cette date |
| `income_group` | VARCHAR(50) | Oui | Classification par niveau de revenu du pays |

#### Index Recommandés

Pour améliorer les performances des requêtes, il est recommandé de créer les index suivants :

```sql
-- Index sur la date pour les analyses temporelles
CREATE INDEX idx_covid_analysis_date ON covid_analysis(date);

-- Index sur le pays pour les agrégations par pays
CREATE INDEX idx_covid_analysis_country ON covid_analysis(country);

-- Index sur le continent pour les analyses continentales
CREATE INDEX idx_covid_analysis_continent ON covid_analysis(continent);

-- Index composite pour les requêtes fréquentes
CREATE INDEX idx_covid_analysis_country_date ON covid_analysis(country, date);
```

## Valeurs Spéciales

### Colonne `income_group`

Cette colonne est créée lors du nettoyage des données (script `02_data_cleaning.sql`) et contient les valeurs suivantes :

- `High income`
- `Upper middle income`
- `Lower middle income`
- `Low income`
- `NULL` (pour les pays sans classification)

**Source** : Ces valeurs proviennent initialement de la colonne `location` dans les données brutes.

### Colonne `continent`

Valeurs possibles (en anglais) :
- `Africa` (Afrique)
- `Asia` (Asie)
- `Europe` (Europe)
- `North America` (Amérique du Nord)
- `South America` (Amérique du Sud)
- `Oceania` (Océanie)
- `NULL` (pour les agrégations globales supprimées lors du nettoyage)

**Note** : Les noms de pays sont également en anglais (ex: "France", "United States", "China", "United Kingdom").

## Données Supprimées lors du Nettoyage

Les enregistrements suivants sont **supprimés** de `covid_analysis` dans le script `02_data_cleaning.sql` :

1. **Agrégations par niveau de revenu** : Lignes où `location` contient `income`
   - Exemples : "High income", "Low income", etc.
   - Action : Transférées vers la colonne `income_group` puis supprimées

2. **Agrégations géographiques** : Lignes où `location` contient des agrégations
   - Exemples : "World", "Asia", "Europe", "European Union (27)", etc.
   - Raison : Ce ne sont pas des pays individuels

## Statistiques des Données

Après nettoyage, la table `covid_analysis` contient :
- Environ **217 pays** distincts
- Période couverte : de la première date disponible à la dernière date disponible
- Granularité : **1 enregistrement par pays par jour**

## Notes Importantes

### Cumul vs Nouveaux Cas

- **`total_cases`** et **`total_deaths`** : Valeurs **cumulatives** (toujours croissantes ou stables)
  - Pour obtenir le maximum par pays : utiliser `MAX(total_cases)`
  - ⚠️ **Ne jamais utiliser `SUM(total_cases)`** car cela compte plusieurs fois les mêmes cas

- **`new_cases`** et **`new_deaths`** : Valeurs **quotidiennes** (différence par jour)
  - Pour obtenir le total sur une période : utiliser `SUM(new_cases)`

### Gestion des Valeurs NULL

De nombreuses colonnes peuvent contenir des valeurs `NULL`, particulièrement :
- Au début de la pandémie (données incomplètes)
- Pour certains pays avec des rapports irréguliers

**Bonne pratique** : Toujours utiliser `NULLIF()` pour éviter les divisions par zéro et filtrer les NULL avec `WHERE ... IS NOT NULL` quand nécessaire.

Exemple :
```sql
ROUND(
    (SUM(total_deaths) * 100.0 / NULLIF(SUM(total_cases), 0))::NUMERIC,
    2
) AS taux_mortalite
```

## Évolution du Schéma

| Version | Date | Changement |
|---------|------|------------|
| 1.0 | Initial | Création de `covid_analysis` depuis `covid_raw` |
| 1.1 | Nettoyage | Ajout de la colonne `income_group` |
| 1.2 | Nettoyage | Renommage `location` → `country` |
| 1.3 | Nettoyage | Suppression des agrégations non-pays |

## Requêtes Utiles de Diagnostic

### Vérifier le volume de données
```sql
SELECT
    COUNT(*) AS total_lignes,
    COUNT(DISTINCT country) AS nb_pays,
    MIN(date) AS premiere_date,
    MAX(date) AS derniere_date
FROM covid_analysis;
```

### Identifier les valeurs NULL
```sql
SELECT
    COUNT(*) FILTER (WHERE total_cases IS NULL) AS null_cases,
    COUNT(*) FILTER (WHERE total_deaths IS NULL) AS null_deaths,
    COUNT(*) FILTER (WHERE population IS NULL) AS null_population
FROM covid_analysis;
```

### Vérifier les pays par continent
```sql
SELECT
    continent,
    COUNT(DISTINCT country) AS nb_pays
FROM covid_analysis
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY nb_pays DESC;
```
