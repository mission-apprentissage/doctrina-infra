#!/usr/bin/env bash
set -euo pipefail
#Needs to be run as sudo

bash /opt/doctrina/tools/backup-mongodb.sh
bash /opt/doctrina/cli.sh migrate
