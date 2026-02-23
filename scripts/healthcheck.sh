#!/usr/bin/env bash
set -euo pipefail

echo "Caddy:"
docker ps --filter name=qr_caddy

echo "API:"
curl -fsS https://qr.jjdev.ar/docs >/dev/null && echo "API OK" || (echo "API FAIL" && exit 1)
