# BTS SIO SISR – TP PAM avec CyberArk Conjur Community dans GitHub Classroom et Codespaces

## Contexte

Ce dépôt vous est distribué via GitHub Classroom.  
Chaque élève travaille sur sa propre copie du projet.

Le travail demandé se fait dans GitHub Codespaces.  
Vous n'avez pas à installer localement l'environnement avant de commencer, sauf indication contraire de l'enseignant.

L'objectif du TP est de :
- démarrer l'environnement du projet dans Codespaces ;
- lancer CyberArk Conjur Community ;
- créer ou charger une policy ;
- stocker un secret d'infrastructure ;
- vérifier qu'un hôte autorisé peut lire ce secret ;
- comprendre comment le principe du moindre privilège est appliqué.

---

## Règle de travail dans GitHub Classroom

Vous devez travailler dans **votre dépôt personnel GitHub Classroom**.

Cela signifie que :
- vous ne modifiez pas le dépôt du professeur ;
- vous effectuez toutes vos manipulations dans votre propre copie ;
- vous enregistrez vos modifications avec des commits si l'enseignant vous le demande.

---

## Ouvrir le projet dans GitHub Codespaces

1. Ouvrir votre dépôt GitHub Classroom.
2. Cliquer sur **Code**.
3. Cliquer sur **Codespaces**.
4. Cliquer sur **Create codespace on main**.

Attendre que l'environnement termine son démarrage.

---

## Vérifier le contenu du projet

Dans le terminal Codespaces, tapez :

```bash
ls
```

Cette commande permet de vérifier que vous êtes bien à la racine du projet.

Vous devez voir les dossiers et fichiers principaux du template, par exemple :
- les scripts ;
- les fichiers de policy ;
- la documentation ;
- les fichiers de configuration du projet.

---

## Vérifier si Docker est disponible

Dans le terminal Codespaces, tapez :

```bash
docker --version
docker compose version
```

Ces commandes permettent de vérifier que Docker et Docker Compose sont disponibles dans l'environnement Codespaces.

---

## Se placer dans le dossier du projet si nécessaire

Si vous avez ouvert un sous-dossier par erreur, revenez à la racine du dépôt avant d'exécuter les commandes du TP.

Commande utile :

```bash
pwd
```

Cette commande permet d'afficher le dossier courant.

---

## Rendre les scripts exécutables

Si le projet contient des scripts shell, tapez :

```bash
find . -name "*.sh" -exec chmod +x {} \;
```

Cette commande permet de rendre exécutables tous les scripts shell du dépôt.

---

## Démarrer l'environnement Conjur

Consultez d'abord le contenu du dépôt pour identifier :
- le fichier `docker-compose.yml` ou `compose.yml` s'il existe ;
- le dossier contenant les scripts de démarrage ;
- le quickstart ou la documentation fournie.

Si le template contient un fichier `docker-compose.yml`, tapez :

```bash
docker compose up -d
```

Cette commande permet de démarrer les conteneurs nécessaires au projet.

Puis tapez :

```bash
docker compose ps
```

Cette commande permet de vérifier que les services sont bien démarrés.

Si le template utilise un script de démarrage fourni par l'enseignant, exécutez ce script à la place.

Exemple générique :

```bash
./scripts/start-conjur.sh
```

Cette commande sert à lancer automatiquement l'environnement Conjur si le template fournit ce script.

---

## Identifier l'URL Codespaces utile

Dans l'onglet **Ports** de GitHub Codespaces :
- repérer le port exposé pour Conjur ;
- ouvrir l'URL associée si l'enseignant vous demande de vérifier l'accès via navigateur.

Vous devez utiliser **l'URL générée par Codespaces**.  
Vous ne devez pas utiliser `localhost` ou `127.0.0.1` dans le navigateur.

---

## Charger une policy

Repérez le fichier de policy YAML demandé par l'enseignant.

Commande générique :

```bash
conjur policy load -b root -f NOM_DU_FICHIER.yml
```

Cette commande permet de charger dans Conjur une policy définissant :
- les hôtes ;
- les groupes ;
- les variables ;
- les permissions.

Remplacez `NOM_DU_FICHIER.yml` par le nom exact du fichier fourni dans le dépôt.

Si la commande `conjur` doit être lancée depuis un conteneur, utilisez la commande fournie dans le README technique du projet ou par l'enseignant.

---

## Créer ou stocker un secret

Commande générique :

```bash
conjur variable set -i CHEMIN/DU/SECRET -v "VALEUR_DU_SECRET"
```

Cette commande permet d'enregistrer un secret dans Conjur.

Exemple :

```bash
conjur variable set -i webservers/db/password -v "MotDePasseSecurise123!"
```

---

## Vérifier la lecture d'un secret

Commande générique :

```bash
conjur variable get -i CHEMIN/DU/SECRET
```

Cette commande permet de lire un secret stocké dans Conjur.

Elle permet de vérifier que :
- le secret existe ;
- le rôle utilisé possède les droits nécessaires.

---

## Travail demandé

Vous devez effectuer les actions suivantes :

1. Ouvrir votre dépôt GitHub Classroom dans Codespaces.
2. Vérifier la présence des fichiers du projet.
3. Rendre les scripts exécutables si nécessaire.
4. Démarrer l'environnement Conjur.
5. Charger une policy fournie dans le dépôt.
6. Créer un secret.
7. Vérifier la lecture du secret.
8. Expliquer à quoi sert la policy.
9. Expliquer en quoi cette organisation applique le principe du moindre privilège.

---

## Traces à conserver

Selon la consigne de l'enseignant, vous pouvez devoir conserver :
- une capture du terminal après le démarrage ;
- une capture des services actifs ;
- une copie de la policy utilisée ;
- la sortie de lecture du secret ;
- vos modifications enregistrées dans Git.

---

## Résultat attendu

À la fin du TP :
- le projet a été lancé depuis GitHub Codespaces ;
- l'environnement Conjur est démarré ;
- une policy a été chargée ;
- un secret a été enregistré ;
- la lecture du secret fonctionne ;
- vous êtes capable d'expliquer le rôle des hosts, layers, variables et permissions.

---

## À retenir

Ce TP montre que :
- GitHub Classroom permet de distribuer un travail individuel ;
- GitHub Codespaces permet d'exécuter le projet dans un environnement homogène ;
- Conjur permet de sécuriser les secrets d'infrastructure ;
- les policies permettent de contrôler précisément qui peut lire un secret ;
- la sécurité repose sur la limitation des droits et la traçabilité des accès.
