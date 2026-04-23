#!/usr/bin/env bash
set -euo pipefail

ACCOUNT="${CONJUR_ACCOUNT:-myorg}"
URL="${CONJUR_APPLIANCE_URL:-http://localhost}"

echo "Initialisation CLI Conjur"
echo "Commande à exécuter si le CLI est installé :"
echo "conjur init -u ${URL} -a ${ACCOUNT}"
echo "conjur login -i admin -p <API_KEY>"
echo "conjur whoami"
