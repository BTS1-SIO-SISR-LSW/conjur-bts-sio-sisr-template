#!/usr/bin/env bash
set -euo pipefail

echo "Commandes d'injection de secrets :"
echo "conjur variable set -i webservers/db/password -v 'P@ssw0rdSecur3!'"
echo "conjur variable set -i webservers/db/username -v 'web_user'"
echo "conjur variable set -i network/snmp/community -v 'public-demo'"
echo "conjur variable set -i network/backup/password -v 'B4ckup#2026'"
