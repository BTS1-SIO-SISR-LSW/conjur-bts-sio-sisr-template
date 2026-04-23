#!/usr/bin/env bash
set -euo pipefail

echo "Démarrage de la stack Conjur..."
docker compose up -d

echo "Vérification des services :"
docker compose ps

echo "Étape suivante : initialiser Conjur avec ./scripts/init-cli.sh"
