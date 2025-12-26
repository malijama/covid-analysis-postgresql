# Analyse des Données COVID-19 avec PostgreSQL

## Description du Projet

Ce projet propose une analyse complète des données COVID-19 en utilisant PostgreSQL. Il comprend des requêtes SQL pour explorer les tendances, calculer des statistiques clés et identifier les patterns dans la propagation du virus à travers différents pays et continents.

**Note importante** : Les données et noms de colonnes sont en **anglais** (format international), mais toutes les analyses SQL sont **commentées en français** pour faciliter la compréhension.

## Table des Matières

- [Prérequis](#prérequis)
- [Structure du Projet](#structure-du-projet)
- [Installation et Configuration](#installation-et-configuration)
- [Utilisation](#utilisation)
- [Analyses Disponibles](#analyses-disponibles)
- [Structure des Données](#structure-des-données)
- [Auteur](#auteur)

## Prérequis

- PostgreSQL 12 ou supérieur
- Python 3.8 ou supérieur (pour l'importation des données)
- Bibliothèques Python : `pandas`, `sqlalchemy`, `psycopg2`
- Une base de données PostgreSQL configurée

## Structure du Projet

```
SQL/
├── 00_import_covid.ipynb           # Notebook Python - Téléchargement et import des données
├── 01_setup_and_overview.sql       # Configuration initiale et vue d'ensemble
├── 02_data_cleaning.sql            # Nettoyage et préparation des données
├── 03_global_analysis.sql          # Analyses statistiques globales (8 questions)
├── 04_time_series_analysis.sql     # Analyses temporelles et tendances (9 questions)
├── README.md                       # Documentation du projet
├── SCHEMA.md                       # Documentation de la structure des données
├── GITHUB_SETUP.md                 # Guide pour les mises à jour GitHub
├── requirements.txt                # Dépendances Python
└── .gitignore                      # Configuration Git
```

## Installation et Configuration

### 1. Cloner le dépôt

```bash
git clone https://github.com/malijama/covid-analysis-postgresql.git
cd covid-analysis-postgresql
```

### 2. Installer les dépendances Python

```bash
pip install -r requirements.txt
```

### 3. Créer la base de données PostgreSQL

```sql
CREATE DATABASE postgres;  -- ou utilisez votre base existante
```

### 4. Importer les données COVID-19

Ouvrez le notebook Jupyter `00_import_covid.ipynb` et :
- Modifiez le mot de passe PostgreSQL dans le notebook
- Exécutez toutes les cellules pour télécharger et importer les données

Le notebook va :
- Télécharger les données depuis [Our World in Data](https://github.com/owid/covid-19-data)
- Créer automatiquement la table `covid_raw`
- Importer environ 430 000 lignes de données

**Source des données** : Our World in Data COVID-19 Dataset (mise à jour quotidienne)

### 5. Exécuter les scripts SQL dans l'ordre

```bash
psql -d postgres -f 01_setup_and_overview.sql
psql -d postgres -f 02_data_cleaning.sql
psql -d postgres -f 03_global_analysis.sql
psql -d postgres -f 04_time_series_analysis.sql
```

## Utilisation

Les scripts sont conçus pour être exécutés séquentiellement :

### Étape 0 : Importation des Données (00_import_covid.ipynb)
- Télécharge les données COVID-19 depuis Our World in Data
- Sélectionne les colonnes pertinentes pour l'analyse
- Crée et remplit la table `covid_raw` dans PostgreSQL
- **Volume** : ~430 000 lignes (tous les pays, toutes les dates)

### Étape 1 : Configuration (01_setup_and_overview.sql)
- Réinitialise la table d'analyse
- Copie les données brutes vers la table de travail `covid_analysis`
- Vérifie le volume et la période couverte par les données

### Étape 2 : Nettoyage (02_data_cleaning.sql)
- Identifie et traite les anomalies dans les données
- Crée une colonne `income_group` pour les classifications par revenu
- Supprime les agrégations (continents, régions) de la colonne `location`
- Renomme `location` en `country` pour plus de clarté

### Étape 3 : Analyses Globales (03_global_analysis.sql)
- 8 questions d'analyse statistique par pays et continent
- Calculs de taux de mortalité et parts de population infectée
- Identification des pays les plus touchés

### Étape 4 : Analyses Temporelles (04_time_series_analysis.sql)
- 9 questions d'analyse sur les tendances temporelles
- Évolution mensuelle et hebdomadaire
- Calculs de taux de croissance
- Identification des périodes critiques

## Analyses Disponibles

### Analyses Globales (03_global_analysis.sql)

| Question | Description | Techniques SQL |
|----------|-------------|----------------|
| Q1 | Nombre de pays dans le dataset | `COUNT DISTINCT` |
| Q2 | Nombre de pays par continent | `GROUP BY`, `COUNT DISTINCT` |
| Q3 | Top 10 des pays les plus peuplés | `ORDER BY`, `LIMIT` |
| Q4 | Population totale par continent | Sous-requête, `SUM` avec déduplication |
| Q5 | Pays avec le plus de cas cumulés | `MAX`, `GROUP BY` |
| Q6 | Taux de mortalité par continent | Calculs de pourcentage, `NULLIF` |
| Q7 | Part de population infectée (dernière date) | `DISTINCT ON`, sous-requête |
| Q8 | Part de population décédée | `DISTINCT ON`, sous-requête |

### Analyses Temporelles (04_time_series_analysis.sql)

| Question | Description | Techniques SQL |
|----------|-------------|----------------|
| Q1 | Évolution mensuelle des cas | `to_char`, agrégation temporelle |
| Q2 | Évolution hebdomadaire avec différence | `LAG`, window functions |
| Q3 | Mois avec le plus de nouveaux cas | `date_trunc`, `LIMIT 1` |
| Q4 | Croissance hebdomadaire (%) | `LAG`, calculs de taux de croissance |
| Q5 | Durée moyenne de la pandémie par pays | `MIN`, `MAX`, calculs de dates |
| Q6 | Période avec le plus de décès par continent | `date_trunc`, agrégation multiple |
| Q7 | Évolution du taux de mortalité mensuel | Calculs temporels de ratios |
| Q8 | Top 5 pays avec la croissance la plus rapide | Calculs de taux de croissance |
| Q9 | Semaines records par continent | `ROW_NUMBER`, CTE, window functions |

## Structure des Données

### Table : `covid_analysis`

| Colonne | Type | Description |
|---------|------|-------------|
| `date` | DATE | Date de l'enregistrement |
| `country` | VARCHAR | Nom du pays (anciennement `location`) |
| `continent` | VARCHAR | Continent |
| `population` | NUMERIC | Population du pays |
| `total_cases` | NUMERIC | Nombre cumulé de cas confirmés |
| `new_cases` | NUMERIC | Nouveaux cas pour cette date |
| `total_deaths` | NUMERIC | Nombre cumulé de décès |
| `new_deaths` | NUMERIC | Nouveaux décès pour cette date |
| `income_group` | VARCHAR | Classification par revenu (ajoutée lors du nettoyage) |

## Techniques SQL Utilisées

Ce projet démontre la maîtrise de concepts SQL avancés :

- **Window Functions** : `LAG()`, `ROW_NUMBER()`, `AVG() OVER()`
- **Agrégations Temporelles** : `date_trunc()`, `to_char()`
- **Common Table Expressions (CTE)** : `WITH ... AS`
- **Gestion des NULL** : `NULLIF()`, `COALESCE()`
- **Sous-requêtes** : requêtes imbriquées pour des calculs complexes
- **DISTINCT ON** : extraction de la dernière valeur par groupe
- **Déduplication** : éviter le double comptage dans les agrégations

## Points Clés du Projet

### Qualité du Code
- Commentaires détaillés en français pour chaque requête
- Noms de colonnes explicites et en français
- Gestion appropriée des valeurs NULL
- Optimisation des requêtes pour éviter le double comptage

### Méthodologie
- Approche progressive : setup → cleaning → analysis → time series
- Diagnostic avant action (identification des anomalies)
- Documentation des résultats en commentaires
- Séparation claire des responsabilités par fichier

## Source des Données

Les données COVID-19 utilisées dans ce projet proviennent de **Our World in Data** :
- **URL** : https://github.com/owid/covid-19-data
- **Format** : CSV mis à jour quotidiennement
- **Licence** : Creative Commons BY license
- **Attribution** : Edouard Mathieu, Hannah Ritchie, Lucas Rodés-Guirao, Cameron Appel, Charlie Giattino, Joe Hasell, Bobbie Macdonald, Saloni Dattani, Diana Beltekian, Esteban Ortiz-Ospina and Max Roser (2020) - "Coronavirus Pandemic (COVID-19)". Published online at OurWorldInData.org.

### Colonnes importées (en anglais)

Le notebook `00_import_covid.ipynb` sélectionne les colonnes suivantes depuis Our World in Data :

| Colonne (EN) | Description (FR) | Type |
|--------------|------------------|------|
| `iso_code` | Code ISO du pays | VARCHAR |
| `continent` | Nom du continent | VARCHAR |
| `location` | Nom du pays/région | VARCHAR |
| `date` | Date de l'enregistrement | DATE |
| `total_cases` | Cas confirmés cumulés | NUMERIC |
| `new_cases` | Nouveaux cas quotidiens | NUMERIC |
| `total_deaths` | Décès cumulés | NUMERIC |
| `new_deaths` | Nouveaux décès quotidiens | NUMERIC |
| `total_vaccinations` | Vaccinations totales | NUMERIC |
| `people_vaccinated_per_hundred` | % de population vaccinée | NUMERIC |
| `population` | Population du pays | NUMERIC |

**Note** : Les données sont en anglais (ex: "United States", "France", "China") pour maintenir la cohérence avec la source internationale.

## Auteur

**Mohamed** ([@malijama](https://github.com/malijama))

## Licence

Ce projet est fourni à des fins éducatives et d'analyse.

Les données COVID-19 sont sous licence Creative Commons BY (Our World in Data). Veuillez citer la source appropriée lors de l'utilisation de ces données.

---

**Citation suggérée pour ce projet** :
```
Mohamed (2024). "Analyse des données COVID-19 avec PostgreSQL".
GitHub: https://github.com/malijama/covid-analysis-postgresql
```
