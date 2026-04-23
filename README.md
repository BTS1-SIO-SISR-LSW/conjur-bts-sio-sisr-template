# BTS SIO SISR – CyberArk Conjur Community avec GitHub Classroom et Codespaces

## Contexte

Ce dépôt s'utilise directement dans GitHub Classroom et GitHub Codespaces.

Le laboratoire met en place un environnement Conjur prêt à l'emploi :
- une base PostgreSQL ;
- un serveur Conjur ;
- un client Conjur ;
- une policy YAML ;
- des scripts de démarrage, de chargement et de vérification.

L'objectif est de :
- démarrer l'environnement ;
- charger une policy ;
- enregistrer des secrets ;
- lire les secrets ;
- comprendre le rôle des hosts, layers, variables et permissions.

## Ouvrir le dépôt dans Codespaces

1. Ouvrir le dépôt GitHub Classroom.
2. Cliquer sur **Code**.
3. Cliquer sur **Codespaces**.
4. Cliquer sur **Create codespace on main**.
5. Attendre la fin du démarrage.

## Vérifier la racine du projet

Commande à taper :

```bash
ls
```

Cette commande permet de vérifier que vous êtes bien à la racine du dépôt.  
Vous devez voir notamment :
- `docker-compose.yml`
- `policies`
- `scripts`

## Rendre les scripts exécutables

Commande à taper :

```bash
chmod +x scripts/*.sh
```

Cette commande permet d'autoriser l'exécution de tous les scripts du laboratoire.

## Démarrer le laboratoire

Commande à taper :

```bash
./scripts/start-lab.sh
```

Cette commande permet de :
- télécharger les images Docker nécessaires ;
- générer la clé de données Conjur ;
- démarrer les conteneurs ;
- créer le compte `btslab` ;
- initialiser le client Conjur ;
- connecter le client avec l'utilisateur `admin`.

Le premier démarrage peut prendre plusieurs minutes.

## Vérifier les services actifs

Commande à taper :

```bash
./scripts/check-services.sh
```

Cette commande permet d'afficher l'état des conteneurs.

## Charger la policy

Commande à taper :

```bash
./scripts/load-policy.sh
```

Cette commande permet de charger la policy `policies/lab.yml` dans Conjur.

La policy crée :
- deux variables de secret ;
- un layer nommé `prod-web` ;
- deux hosts nommés `web-01` et `web-02` ;
- les permissions de lecture sur les secrets pour le layer.

## Enregistrer les secrets

Commande à taper :

```bash
./scripts/store-secret.sh
```

Cette commande permet d'enregistrer deux secrets dans Conjur :
- `webservers/db/username`
- `webservers/db/password`

## Lire les secrets

Commande à taper :

```bash
./scripts/read-secrets.sh
```

Cette commande permet de vérifier que les secrets ont bien été stockés.

## Lire la policy

Commande à taper :

```bash
cat policies/lab.yml
```

Cette commande permet de relire la structure de la policy et d'identifier :
- les variables ;
- le layer ;
- les hosts ;
- le grant ;
- le permit.

## Arrêter le laboratoire

Commande à taper :

```bash
./scripts/stop-lab.sh
```

Cette commande permet d'arrêter tous les conteneurs du laboratoire.

## Résultat attendu

À la fin du travail :
- les conteneurs Conjur sont démarrés ;
- la policy est chargée ;
- les secrets sont enregistrés ;
- les secrets peuvent être lus ;
- la structure de contrôle d'accès est identifiable dans le fichier YAML.

## Ce qu'il faut retenir

Conjur permet de gérer des secrets d'infrastructure à l'aide :
- d'identités non humaines ;
- de policies YAML ;
- de permissions précises sur les ressources.

Le principe du moindre privilège est visible dans ce laboratoire : seuls les rôles autorisés reçoivent un droit de lecture sur les secrets.

## Commandes récapitulatives

```bash
ls
chmod +x scripts/*.sh
./scripts/start-lab.sh
./scripts/check-services.sh
./scripts/load-policy.sh
./scripts/store-secret.sh
./scripts/read-secrets.sh
cat policies/lab.yml
./scripts/stop-lab.sh
```
