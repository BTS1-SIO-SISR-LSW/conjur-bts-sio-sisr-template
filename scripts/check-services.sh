#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

docker compose ps
echo
echo "Le port 8443 n'est pas exposé par ce template."
echo "Dans Codespaces, utilisez uniquement l'URL générée par l'onglet Ports si vous ouvrez un port."
