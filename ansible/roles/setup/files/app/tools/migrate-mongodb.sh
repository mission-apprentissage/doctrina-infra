#!/usr/bin/env bash
set -euo pipefail
#Needs to be run as sudo

bash /opt/lba/tools/backup-mongodb.sh
bash /opt/lba/cli.sh migrate
