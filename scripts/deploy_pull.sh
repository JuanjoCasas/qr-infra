#!/usr/bin/env bash
set -euo pipefail

echo "-> Pulling latest code..."
git pull

echo "-> Rebuilding and restarting stack..."
make up

echo "OK"
