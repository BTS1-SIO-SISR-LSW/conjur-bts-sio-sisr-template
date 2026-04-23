# BTS SIO SISR – PAM avec CyberArk Conjur Community

## Contexte

Ce dépôt s'ouvre directement dans GitHub Codespaces depuis GitHub Classroom.

L'environnement est prêt à l'emploi :
- Docker est configuré dans le Codespace ;
- la pile Conjur démarre avec les bons conteneurs ;
- les policies sont déjà présentes dans le dépôt ;
- les scripts nécessaires sont inclus.

Le travail consiste à :
1. démarrer la plate-forme ;
2. vérifier les services ;
3. charger la configuration Conjur ;
4. stocker des secrets d'infrastructure ;
5. relire ces secrets ;
6. analyser la logique d'autorisation définie dans les policies.

## Structure du dépôt

```text
.
├── .devcontainer/
├── conf/
├── docker-compose.yml
├── policies/
│   ├── policy-network.yml
│   └── policy-webservers.yml
├── scripts/
│   ├── start-lab.sh
│   ├── check-services.sh
│   ├── show-admin-key.sh
│   ├── read-secrets.sh
│   └── stop-lab.sh
└── README.md
```

## Ouverture dans Codespaces

1. Ouvrir le dépôt GitHub Classroom.
2. Cliquer sur `Code`.
3. Cliquer sur `Codespaces`.
4. Cliquer sur `Create codespace on main`.
5. Attendre la fin du démarrage.

## Étape 1 – Vérifier le contenu du dépôt

Commande :

```bash
ls
```

Cette commande affiche les éléments du dépôt et permet de vérifier que vous êtes bien à la racine du projet.

## Étape 2 – Rendre les scripts exécutables

Commande :

```bash
chmod +x scripts/*.sh
```

Cette commande rend exécutables tous les scripts du dossier `scripts`.

## Étape 3 – Démarrer l'environnement complet

Commande :

```bash
./scripts/start-lab.sh
```

Cette commande réalise automatiquement les actions suivantes :
- génère la clé de chiffrement Conjur ;
- crée le fichier `.env` nécessaire au démarrage ;
- lance PostgreSQL, Conjur, Nginx, le client Conjur et pgAdmin ;
- crée le compte Conjur `btssio` ;
- initialise le client Conjur ;
- connecte le client en tant qu'administrateur ;
- charge les deux policies du dépôt ;
- enregistre quatre secrets de démonstration.

Quand la commande se termine, l'environnement est prêt.

## Étape 4 – Vérifier l'état des services

Commande :

```bash
./scripts/check-services.sh
```

Cette commande affiche les conteneurs actifs.

Le résultat attendu est la présence des services suivants en cours d'exécution :
- `postgres_database`
- `conjur_server`
- `nginx_proxy`
- `conjur_client`
- `pgadmin`

## Étape 5 – Afficher la clé API de l'administrateur

Commande :

```bash
./scripts/show-admin-key.sh
```

Cette commande lit le fichier `admin_data` et affiche la clé API du compte `admin`.

Cette clé sert à comprendre comment Conjur initialise un compte administrateur et stocke son API key localement dans le dépôt de travail.

## Étape 6 – Lire les secrets stockés

Commande :

```bash
./scripts/read-secrets.sh
```

Cette commande :
- reconnecte automatiquement le client Conjur avec la clé API de l'administrateur ;
- lit les secrets définis dans les deux policies.

Les secrets relus sont :
- `webservers/db/username`
- `webservers/db/password`
- `network/snmp/community`
- `network/backup/password`

## Étape 7 – Examiner les policies

Commande :

```bash
cat policies/policy-webservers.yml
```

Cette commande affiche la policy des serveurs web.

Commande :

```bash
cat policies/policy-network.yml
```

Cette commande affiche la policy réseau.

Ces deux fichiers permettent d'identifier :
- les variables ;
- les hosts ;
- les layers ;
- les permissions accordées.

## Étape 8 – Vérifier les ports Codespaces

Ouvrir l'onglet `Ports` dans GitHub Codespaces.

Les ports utiles sont :
- `8443` pour l'accès HTTPS à Conjur via Nginx ;
- `8081` pour pgAdmin.

Dans un navigateur, il faut toujours utiliser l'URL générée par Codespaces dans cet onglet.

## Étape 9 – Arrêter l'environnement à la fin du travail

Commande :

```bash
./scripts/stop-lab.sh
```

Cette commande arrête l'ensemble de la plate-forme.

## Commandes récapitulatives

```bash
ls
chmod +x scripts/*.sh
./scripts/start-lab.sh
./scripts/check-services.sh
./scripts/show-admin-key.sh
./scripts/read-secrets.sh
cat policies/policy-webservers.yml
cat policies/policy-network.yml
./scripts/stop-lab.sh
```

## Résultat attendu

À la fin du travail :
- le dépôt a été lancé dans GitHub Codespaces ;
- Conjur fonctionne avec son proxy Nginx et sa base PostgreSQL ;
- les policies ont été chargées ;
- les secrets ont été enregistrés ;
- les secrets peuvent être relus ;
- la différence entre `host`, `layer`, `variable` et `permit` est comprise.

## Points à retenir

- Un secret d'infrastructure ne doit pas être stocké en clair dans un fichier partagé.
- Une policy Conjur définit qui peut lire quoi.
- Les identités machine sont séparées par rôle.
- Le principe du moindre privilège consiste à limiter l'accès aux seuls secrets nécessaires.
