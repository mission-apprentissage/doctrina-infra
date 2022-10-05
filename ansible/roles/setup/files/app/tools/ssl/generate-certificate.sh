#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "/opt/doctrina/data/ssl/privkey.pem" ]; then
  cd "${SCRIPT_DIR}"
    docker build --tag doctrina_certbot certbot/
    docker run --rm --name doctrina_certbot \
      -p 80:5000 \
      -v /opt/doctrina/data/certbot:/etc/letsencrypt \
      -v /opt/doctrina/data/ssl:/ssl \
      doctrina_certbot generate "$@"
  cd -
else
  echo "Certificat SSL déja généré"
fi
