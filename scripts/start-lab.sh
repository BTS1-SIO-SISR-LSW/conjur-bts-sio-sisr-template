#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "Étape 1/5 - Téléchargement des images Docker"
docker compose pull

echo "Étape 2/5 - Génération de la clé de données"
if [ ! -f data_key ]; then
  docker compose run --no-deps --rm conjur data-key generate > data_key
fi

export CONJUR_DATA_KEY="$(< data_key)"

echo "Étape 3/5 - Démarrage des conteneurs"
docker compose up -d

echo "Étape 4/5 - Création du compte Conjur"
if [ ! -f admin_data ]; then
  docker compose exec conjur conjurctl account create btslab > admin_data
fi

echo "Étape 5/5 - Initialisation du client et connexion admin"
docker compose exec client conjur init oss -u https://proxy -a btslab --self-signed >/dev/null 2>&1 || true
ADMIN_API_KEY="$(grep "API key" admin_data | cut -d: -f2 | tr -d ' 
')"
docker compose exec client conjur login -i admin -p "$ADMIN_API_KEY" >/dev/null

echo
echo "Le laboratoire Conjur est prêt."
echo "Commande suivante : ./scripts/check-services.sh"
