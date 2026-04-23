#!/usr/bin/env bash
set -euo pipefail

echo "Commande de chargement de la policy webservers :"
echo "conjur policy load -b root -f policies/policy-webservers.yml"

echo "Commande de chargement de la policy network :"
echo "conjur policy load -b root -f policies/policy-network.yml"
