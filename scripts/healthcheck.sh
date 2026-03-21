#!/usr/bin/env bash
set -euo pipefail

echo "API container:"
docker ps --filter name=api

echo "API health:"
curl -fsS http://localhost:8000/docs >/dev/null && echo "API OK" || (echo "API FAIL" && exit 1)