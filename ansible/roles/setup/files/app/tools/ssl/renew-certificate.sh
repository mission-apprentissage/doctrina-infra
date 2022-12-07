#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DNS_NAME=${1:?"Merci de préciser le nom de domaine"}; shift;

start_reverse_proxy() {
  bash /opt/lba/start-app.sh "$(git --git-dir=/opt/lba/repository/.git rev-parse --abbrev-ref HEAD)" \
    --no-deps reverse_proxy
}

stop_reverse_proxy() {
  bash /opt/lba/stop-app.sh lba_reverse_proxy --no-deps reverse_proxy
}

renew_certificate() {
  cd "${SCRIPT_DIR}"
  docker build --tag lba_certbot certbot/
  docker run --rm --name lba_certbot \
    -p 80:5000 \
    -v /opt/lba/data/certbot:/etc/letsencrypt \
    -v /opt/lba/data/ssl:/ssl \
    lba_certbot renew "${DNS_NAME}"
  cd -
}

handle_error() {
  bash /opt/lba/tools/send-to-slack.sh "[SSL] Unable to renew certificate"
  start_reverse_proxy
}
trap handle_error ERR

echo "****************************"
echo "[$(date +'%Y-%m-%d_%H%M%S')] Running ${BASH_SOURCE[0]} $*"
echo "****************************"
stop_reverse_proxy
renew_certificate
start_reverse_proxy
bash /opt/lba/tools/send-to-slack.sh "[SSL] Certificat has been renewed"
