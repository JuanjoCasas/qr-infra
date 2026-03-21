#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/env/.env.prod"
BACKUP_DIR="$ROOT_DIR/backups"
DB_CONTAINER="${DB_CONTAINER:-qr_db}"

mkdir -p "$BACKUP_DIR"

set -a
source "$ENV_FILE"
set +a

TS="$(date +%Y%m%d_%H%M%S)"
OUT="$BACKUP_DIR/qrdb_${TS}.sql.gz"

echo "-> Creating backup: $OUT"
docker exec -e PGPASSWORD="$POSTGRES_PASSWORD" "$DB_CONTAINER" \
  pg_dump -U "$POSTGRES_USER" -d "$POSTGRES_DB" \
  | gzip > "$OUT"

echo "OK"