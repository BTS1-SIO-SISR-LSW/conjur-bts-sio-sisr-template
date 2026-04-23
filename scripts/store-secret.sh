#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

ADMIN_API_KEY="$(grep "API key" admin_data | cut -d: -f2 | tr -d ' 
')"
docker compose exec client conjur login -i admin -p "$ADMIN_API_KEY" >/dev/null
docker compose exec client conjur variable set -i webservers/db/username -v "web_user"
docker compose exec client conjur variable set -i webservers/db/password -v "MotDePasseSISR123!"

echo "Secrets enregistrés dans Conjur."
echo "Commande suivante : ./scripts/read-secrets.sh"
