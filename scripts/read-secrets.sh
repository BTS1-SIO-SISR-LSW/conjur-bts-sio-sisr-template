#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

ADMIN_API_KEY="$(grep "API key" admin_data | cut -d: -f2 | tr -d ' 
')"
docker compose exec client conjur login -i admin -p "$ADMIN_API_KEY" >/dev/null

echo "Lecture de webservers/db/username"
docker compose exec client conjur variable get -i webservers/db/username
echo
echo "Lecture de webservers/db/password"
docker compose exec client conjur variable get -i webservers/db/password
