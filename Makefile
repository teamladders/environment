PROJECT_NAME = teamladders
STORAGE_ROOT = /var/docker/env_teamladders

DOCKER_CMD = docker-compose -p $(PROJECT_NAME)


.PHONY: help dbs build start stop restart status rm postgres redis nginx app


help:
	@echo "COMMANDS: help build start stop restart rm status app nginx mysql\nRead README.md for more information";

dbs:
	#TODO create DBs

build:
	@echo "== build containers";
	@mkdir -p $(STORAGE_ROOT)/postgres
	@mkdir -p $(STORAGE_ROOT)/nginx/conf.d
	@mkdir -p $(STORAGE_ROOT)/nginx/log
	@mkdir -p $(STORAGE_ROOT)/redis
	@mkdir -p $(STORAGE_ROOT)/php-fpm
	@mkdir -p $(STORAGE_ROOT)/work
	@cp -pu conf/redis/redis.conf $(STORAGE_ROOT)/redis
	@cp -pu conf/nginx/nginx.conf $(STORAGE_ROOT)/nginx
	@cp -pu conf/nginx/conf.d/default $(STORAGE_ROOT)/nginx/conf.d
	@cp -pu conf/php-fpm/php.ini $(STORAGE_ROOT)/php-fpm
	@$(DOCKER_CMD) build

start:
	@echo "== start containers";
	@mkdir -p $(STORAGE_ROOT)/postgres
	@mkdir -p $(STORAGE_ROOT)/nginx/conf.d
	@mkdir -p $(STORAGE_ROOT)/nginx/log
	@mkdir -p $(STORAGE_ROOT)/redis
	@mkdir -p $(STORAGE_ROOT)/php-fpm
	@mkdir -p $(STORAGE_ROOT)/work
	@cp -pu conf/redis/redis.conf $(STORAGE_ROOT)/redis
	@cp -pu conf/nginx/nginx.conf $(STORAGE_ROOT)/nginx
	@cp -pu conf/nginx/conf.d/default $(STORAGE_ROOT)/nginx/conf.d
	@cp -pu conf/php-fpm/php.ini $(STORAGE_ROOT)/php-fpm
	@$(DOCKER_CMD) up -d

stop:
	@echo "== stop containers";
	@$(DOCKER_CMD) stop

restart:
	@echo "== restart containers";
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