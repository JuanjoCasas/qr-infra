ENV_FILE=env/.env.prod
COMPOSE=docker compose -f compose/docker-compose.prod.yml --env-file $(ENV_FILE)

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

restart:
	$(COMPOSE) down
	$(COMPOSE) up -d

logs:
	$(COMPOSE) logs -f --tail=200

ps:
	$(COMPOSE) ps

pull:
	$(COMPOSE) pull

migrate:
	$(COMPOSE) exec api alembic upgrade head

backup:
	bash scripts/backup_db.sh

restore:
	bash scripts/restore_db.sh "$(FILE)"