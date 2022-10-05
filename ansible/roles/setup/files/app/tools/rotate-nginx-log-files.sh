#!/usr/bin/env bash
set -euo pipefail

echo "****************************"
echo "[$(date +'%Y-%m-%d_%H%M%S')] Running ${BASH_SOURCE[0]} $*"
echo "****************************"
docker exec doctrina_reverse_proxy bash -c "/usr/sbin/logrotate -s /data/status /etc/logrotate.conf"
