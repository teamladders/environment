PROJECT_NAME = teamladders

ifndef TEAMLADDERS_STORAGE_ROOT
	export TEAMLADDERS_STORAGE_ROOT="/var/docker/env_teamladders"
endif

DOCKER_CMD = docker-compose -p $(PROJECT_NAME)


.PHONY: help dbs build start stop restart status rm postgres redis nginx app


help:
	@echo "COMMANDS: help build start stop restart rm status app nginx mysql\nRead README.md for more information";

dbs:
	@export PGPASSWORD='postgres'
	@psql -h 127.0.0.1 -p 5432 --username=postgres -c "CREATE DATABASE teamladders;"
	@psql -h 127.0.0.1 -p 5432 --username=postgres -c "GRANT ALL PRIVILEGES ON database teamladders TO postgres;"

build:
	@echo "== build containers";
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/postgres
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/nginx/conf.d
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/nginx/log
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/redis
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/php-fpm
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/work
	@rsync -u conf/redis/ $(TEAMLADDERS_STORAGE_ROOT)/redis
	@rsync -u conf/nginx/ $(TEAMLADDERS_STORAGE_ROOT)/nginx
	@rsync -u conf/php-fpm/ $(TEAMLADDERS_STORAGE_ROOT)/php-fpm
	@$(DOCKER_CMD) build

start:
	@echo "== start containers";
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/postgres
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/nginx/conf.d
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/nginx/log
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/redis
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/php-fpm
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/work
	@rsync -u conf/redis/ $(TEAMLADDERS_STORAGE_ROOT)/redis
	@rsync -u conf/nginx/ $(TEAMLADDERS_STORAGE_ROOT)/nginx
	@rsync -u conf/php-fpm/ $(TEAMLADDERS_STORAGE_ROOT)/php-fpm
	@$(DOCKER_CMD) up -d

stop:
	@echo "== stop containers";
	@$(DOCKER_CMD) stop

restart:
	@echo "== restart containers";
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/postgres
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/nginx/conf.d
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/nginx/log
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/redis
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/php-fpm
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/work
	@rsync -u conf/redis/ $(TEAMLADDERS_STORAGE_ROOT)/redis
	@rsync -u conf/nginx/ $(TEAMLADDERS_STORAGE_ROOT)/nginx
	@rsync -u conf/php-fpm/ $(TEAMLADDERS_STORAGE_ROOT)/php-fpm
	@$(DOCKER_CMD) restart

rm:
	@echo "== stop and remove containers";
	@$(DOCKER_CMD) down

status:
	@$(DOCKER_CMD) ps

postgres:
	@docker exec -ti teamladders_postgres bash

redis:
	@docker exec -ti teamladders_redis bash

nginx:
	@docker exec -ti teamladders_nginx bash

app:
	@docker exec -ti teamladders_fpm bash
