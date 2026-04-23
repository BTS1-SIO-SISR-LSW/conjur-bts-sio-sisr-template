#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

ADMIN_API_KEY="$(grep "API key" admin_data | cut -d: -f2 | tr -d ' 
')"
docker compose exec client conjur login -i admin -p "$ADMIN_API_KEY" >/dev/null
docker compose exec client conjur policy load -b root -f /policy/lab.yml > my_app_data

echo "Policy chargée : policies/lab.yml"
echo "Commande suivante : ./scripts/store-secret.sh"
