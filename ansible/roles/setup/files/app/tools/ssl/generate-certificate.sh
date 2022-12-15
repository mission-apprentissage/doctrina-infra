#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "/opt/lba/data/ssl/privkey.pem" ]; then
  cd "${SCRIPT_DIR}"
    docker build --tag lba_certbot certbot/
    docker run --rm --name lba_certbot \
      -p 80:5000 \
      -v /opt/lba/data/certbot:/etc/letsencrypt \
      -v /opt/lba/data/ssl:/ssl \
      lba_certbot generate "$@"
  cd -
else
  echo "Certificat SSL déja généré"
fi
