#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

ACCOUNT="btssio"

if [ ! -f data_key ]; then
  docker compose run --no-deps --rm conjur data-key generate > data_key
fi

DATA_KEY="$(tr -d '\r\n' < data_key)"

cat > .env <<EOF
CONJUR_ACCOUNT=${ACCOUNT}
CONJUR_APPLIANCE_URL=https://proxy
CONJUR_DATA_KEY=${DATA_KEY}
EOF

docker compose up -d
sleep 15

if [ ! -f admin_data ]; then
  docker compose exec -T conjur conjurctl account create "${ACCOUNT}" > admin_data
fi

printf 'y\n' | docker compose exec -T client conjur init oss -u https://proxy -a "${ACCOUNT}" --self-signed

ADMIN_API_KEY="$(grep 'API key for admin' admin_data | cut -d: -f2- | tr -d ' \r\n')"
docker compose exec -T client conjur login -i admin -p "${ADMIN_API_KEY}"

docker compose exec -T client conjur policy load -b root -f /policy/policy-webservers.yml
docker compose exec -T client conjur policy load -b root -f /policy/policy-network.yml

docker compose exec -T client conjur variable set -i webservers/db/password -v 'P@ssw0rdSecur3!'
docker compose exec -T client conjur variable set -i webservers/db/username -v 'web_user'
docker compose exec -T client conjur variable set -i network/snmp/community -v 'public-demo'
docker compose exec -T client conjur variable set -i network/backup/password -v 'B4ckup#2026'

echo
echo "Environnement prêt."
echo "Port Conjur HTTPS : 8443"
echo "Port pgAdmin : 8081"
echo "Compte Conjur : ${ACCOUNT}"
echo "API key admin enregistrée dans le fichier admin_data"
