#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

ADMIN_API_KEY="$(grep 'API key for admin' admin_data | cut -d: -f2- | tr -d ' \r\n')"
docker compose exec -T client conjur login -i admin -p "${ADMIN_API_KEY}" >/dev/null
echo "webservers/db/username"
docker compose exec -T client conjur variable get -i webservers/db/username
echo
echo "webservers/db/password"
docker compose exec -T client conjur variable get -i webservers/db/password
echo
echo "network/snmp/community"
docker compose exec -T client conjur variable get -i network/snmp/community
echo
echo "network/backup/password"
docker compose exec -T client conjur variable get -i network/backup/password
