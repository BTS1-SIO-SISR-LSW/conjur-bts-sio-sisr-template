# Conjur BTS SIO SISR Template

Template GitHub Classroom / repository modèle pour mettre en application la gestion des accès privilégiés (PAM) côté **infrastructure, systèmes et réseaux** avec **CyberArk Conjur Community**.

Ce dépôt est conçu pour des étudiants de **BTS SIO option SISR**. Il transforme les idées du cours en un environnement concret basé sur Docker, des policies YAML et une simulation de serveurs web ayant besoin de secrets d'infrastructure.

## Objectifs pédagogiques

À l'issue du travail, l'étudiant doit être capable de :
1. déployer Conjur Community avec Docker Compose ;
2. initialiser l'environnement et se connecter avec le CLI ;
3. charger une policy YAML ;
4. créer et lire des secrets d'infrastructure ;
5. comprendre le principe du moindre privilège appliqué aux machines ;
6. expliquer la différence entre identité machine, layer et variable.

## Compétences BTS SIO mobilisées
- **B1.3** – Gérer le patrimoine informatique
- **B2.2** – Installer et configurer les éléments de sécurité
- **B3.2** – Assurer la cybersécurité des services
- **B3.3** – Sécuriser les échanges d'administration

## Structure du dépôt

```text
conjur-bts-sio-sisr-template/
├─ docs/
│  ├─ sujet.md
│  ├─ corrige-enseignant.md
│  └─ aide-depannage.md
├─ policies/
│  ├─ policy-webservers.yml
│  └─ policy-network.yml
├─ scripts/
│  ├─ quickstart.sh
│  ├─ init-cli.sh
│  ├─ load-policy.sh
│  └─ seed-secrets.sh
├─ docker-compose.yml
├─ .env.example
├─ .github/workflows/
│  └─ yaml-lint-reminder.yml
└─ README.md
```

## Pré-requis
- Docker Desktop ou Docker Engine + plugin Compose ;
- Git ;
- terminal Bash ou PowerShell ;
- éventuellement GitHub Codespaces si Docker y est disponible.

## Démarrage rapide

### 1. Cloner le dépôt

```bash
git clone <URL_DU_DEPOT>
cd conjur-bts-sio-sisr-template
```

### 2. Copier le fichier d'environnement

```bash
cp .env.example .env
```

### 3. Démarrer l'environnement

```bash
docker compose up -d
```

### 4. Vérifier les services

```bash
docker compose ps
```

### 5. Initialiser l'environnement Conjur

```bash
chmod +x scripts/*.sh
./scripts/quickstart.sh
./scripts/init-cli.sh
```

### 6. Charger une policy et injecter des secrets

```bash
./scripts/load-policy.sh
./scripts/seed-secrets.sh
```

## Parcours proposé aux étudiants

### Partie A – Déploiement
1. démarrer la stack Docker ;
2. vérifier que les services sont UP ;
3. relever le rôle de PostgreSQL, Nginx et Conjur.

### Partie B – RBAC et identité machine
1. ouvrir `policies/policy-webservers.yml` ;
2. identifier les `variables`, `hosts`, `layers` et `permit` ;
3. expliquer quel secret peut être lu par quels serveurs.

### Partie C – Mise en sécurité
1. stocker un mot de passe de base de données dans Conjur ;
2. tester la lecture du secret ;
3. modifier la policy pour ajouter un troisième serveur ;
4. proposer une variante plus restrictive.

## Livrables attendus
- capture de `docker compose ps` ;
- capture du chargement de policy ;
- explication du rôle du layer ;
- réponse argumentée sur le moindre privilège ;
- policy modifiée si demandé.
