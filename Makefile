ENV_FILE=../env/.env.prod
COMPOSE=docker compose -f compose/docker-compose.prod.yml --env-file $(ENV_FILE)

up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

restart:
	$(COMPOSE) down
	$(COMPOSE) up -d --build

logs:
	$(COMPOSE) logs -f --tail=200

ps:
	$(COMPOSE) ps

pull:
	$(COMPOSE) pull

# Ejecuta migraciones (si tu qr-core incluye Alembic)
migrate:
	$(COMPOSE) exec api alembic upgrade head

# Backups
backup:
	bash scripts/backup_db.sh

restore FILE?=:
	bash scripts/restore_db.sh "$(FILE)"
