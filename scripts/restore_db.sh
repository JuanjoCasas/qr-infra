#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-}"
if [[ -z "$FILE" ]]; then
  echo "Usage: restore_db.sh /path/to/backup.sql.gz"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/env/.env.prod"

set -a
source "$ENV_FILE"
set +a

echo "-> Restoring backup: $FILE"
gunzip -c "$FILE" | docker exec -i -e PGPASSWORD="$POSTGRES_PASSWORD" qr_db \
  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB"

echo "OK"
