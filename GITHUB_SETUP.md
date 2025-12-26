# Guide de Publication sur GitHub

Ce guide vous aidera à publier votre projet d'analyse COVID-19 sur GitHub.

## Méthode 1 : Via l'Interface Web GitHub (Recommandée pour les débutants)

### Étape 1 : Créer un nouveau dépôt sur GitHub.com

1. Allez sur [GitHub.com](https://github.com) et connectez-vous
2. Cliquez sur le bouton **"+"** en haut à droite, puis **"New repository"**
3. Remplissez les informations :
   - **Repository name** : `covid-analysis-postgresql` (ou le nom de votre choix)
   - **Description** : `Analyse des données COVID-19 avec PostgreSQL - Requêtes SQL avancées et analyses temporelles`
   - **Visibilité** : Public ou Private (à votre choix)
   - ⚠️ **NE PAS** cocher "Initialize this repository with a README" (nous en avons déjà un)
   - ⚠️ **NE PAS** ajouter de .gitignore ou license (nous en avons déjà)
4. Cliquez sur **"Create repository"**

### Étape 2 : Lier votre dépôt local au dépôt GitHub

Copiez et exécutez ces commandes dans votre terminal :

```bash
# Allez dans le dossier du projet
cd "/Users/mohamed/Library/Mobile Documents/com~apple~CloudDocs/Programmation /SQL"

# Liez votre dépôt local au dépôt GitHub (remplacez USERNAME par votre nom d'utilisateur GitHub)
git remote add origin https://github.com/malijama/covid-analysis-postgresql.git

# Vérifiez que la connexion est correcte
git remote -v
```

### Étape 3 : Pousser votre code sur GitHub

```bash
# Poussez votre code sur GitHub
git push -u origin main
```

Si on vous demande vos identifiants :
- **Username** : votre nom d'utilisateur GitHub
- **Password** : votre Personal Access Token (PAS votre mot de passe GitHub)

### Étape 4 : Vérifier la publication

Allez sur `https://github.com/malijama/covid-analysis-postgresql` pour voir votre projet en ligne !

---

## Méthode 2 : Via GitHub CLI (Pour utilisateurs avancés)

Si vous préférez utiliser la ligne de commande, installez d'abord GitHub CLI :

```bash
# Installer GitHub CLI avec Homebrew (macOS)
brew install gh

# S'authentifier
gh auth login

# Créer le dépôt et pousser le code automatiquement
cd "/Users/mohamed/Library/Mobile Documents/com~apple~CloudDocs/Programmation /SQL"
gh repo create covid-analysis-postgresql --public --source=. --remote=origin --push
```

---

## Créer un Personal Access Token (si nécessaire)

Si GitHub demande un mot de passe lors du push et refuse votre mot de passe habituel :

1. Allez sur [GitHub.com → Settings → Developer settings → Personal access tokens → Tokens (classic)](https://github.com/settings/tokens)
2. Cliquez sur **"Generate new token"** → **"Generate new token (classic)"**
3. Donnez un nom : `COVID Analysis Project`
4. Sélectionnez les permissions :
   - ✅ `repo` (tous les sous-items)
5. Cliquez sur **"Generate token"**
6. **COPIEZ LE TOKEN IMMÉDIATEMENT** (vous ne pourrez plus le revoir)
7. Utilisez ce token comme mot de passe lors du `git push`

---

## Commandes Utiles Après Publication

### Vérifier le statut
```bash
cd "/Users/mohamed/Library/Mobile Documents/com~apple~CloudDocs/Programmation /SQL"
git status
```

### Voir l'historique des commits
```bash
git log --oneline
```

### Ajouter des modifications futures
```bash
# Après avoir modifié des fichiers
git add .
git commit -m "Description de vos modifications"
git push
```

### Mettre à jour depuis GitHub (si vous travaillez sur plusieurs machines)
```bash
git pull
```

---

## Dépannage

### Problème : "fatal: remote origin already exists"
```bash
# Supprimer l'ancien remote et en ajouter un nouveau
git remote remove origin
git remote add origin https://github.com/malijama/covid-analysis-postgresql.git
```

### Problème : "failed to push some refs"
```bash
# Forcer le push (ATTENTION : à utiliser seulement pour le premier push)
git push -u origin main --force
```

### Problème : "Support for password authentication was removed"
Vous devez créer un Personal Access Token (voir section ci-dessus).

---

## Prochaines Étapes Recommandées

Une fois votre projet sur GitHub :

1. **Ajoutez des Topics** : Sur GitHub, allez dans votre repo → ⚙️ (à côté de About) → Ajoutez des topics comme `postgresql`, `sql`, `covid-19`, `data-analysis`, `french`

2. **Activez GitHub Pages** (optionnel) : Si vous voulez créer une page web pour votre projet

3. **Ajoutez une LICENSE** : Fichier `LICENSE` pour spécifier les droits d'utilisation

4. **Créez des Issues** : Pour suivre les améliorations futures

5. **Partagez votre projet** : Sur LinkedIn, Twitter, ou votre CV !

---

## Besoin d'Aide ?

Si vous rencontrez des problèmes :
- Vérifiez que vous êtes bien authentifié sur GitHub
- Assurez-vous que le nom du dépôt est disponible
- Consultez la [documentation GitHub](https://docs.github.com)

Bonne chance avec votre projet ! 🚀
