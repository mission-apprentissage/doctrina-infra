#!/usr/bin/env bash
set -euo pipefail
#Needs to be run as sudo

docker exec -it lba_mongodb mongosh mongodb://localhost:27017/lba "$@"
