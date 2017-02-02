SHELL := /bin/bash


ENVFILE = .env
ifneq ("$(wildcard $(ENVFILE))","")
	include $(ENVFILE)
endif

DOCKER_CMD = docker-compose -p $(PROJECT_NAME)


define check_env_file_exists
	@if !([ -f $(1) ]); then \
	   echo "Error: '$(1)' is not found! Try 'make set' to fix it."; \
	   exit 1; \
	fi;
endef

define copy_configs
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/postgres
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/nginx/conf.d
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/nginx/log
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/redis
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/php-fpm
	@mkdir -p $(TEAMLADDERS_STORAGE_ROOT)/work
	@rsync -ur conf/redis/* $(TEAMLADDERS_STORAGE_ROOT)/redis
	@rsync -ur conf/nginx/* $(TEAMLADDERS_STORAGE_ROOT)/nginx
	@rsync -ur conf/php-fpm/* $(TEAMLADDERS_STORAGE_ROOT)/php-fpm
endef


.PHONY: help check-env set dbs cpconfigs build start stop restart status rm postgres redis nginx app

help:
	@printf "COMMANDS:\
		\n\thelp\
		\n\tset\
		\n\tbuild\
		\n\tstart\
		\n\tstop\
		\n\trestart\
		\n\trm\
		\n\tstatus\
		\n\tapp\
		\n\tnginx\
		\n\tmysql\
		\nRead README.md for more information\n";

set:
	@read -p "PROJECT_NAME=" NEW_PROJECT_NAME; \
		printf "PROJECT_NAME=$(strip $$NEW_PROJECT_NAME)\n" > $(ENVFILE);
	@read -p "TEAMLADDERS_STORAGE_ROOT=" NEW_TEAMLADDERS_STORAGE_ROOT; \
		printf "TEAMLADDERS_STORAGE_ROOT=$(strip $$NEW_TEAMLADDERS_STORAGE_ROOT)" >> $(ENVFILE);

dbs:
	@export PGPASSWORD='postgres'; \
		psql -h 127.0.0.1 -p 5432 --username=postgres -c "CREATE DATABASE teamladders;"; \
		psql -h 127.0.0.1 -p 5432 --username=postgres -c "GRANT ALL PRIVILEGES ON database teamladders TO postgres;";

build:
	@echo "== build containers";
	$(call check_env_file_exists,$(ENVFILE))
	$(call copy_configs)
	@$(DOCKER_CMD) build

start:
	@echo "== start containers";
	$(call check_env_file_exists,$(ENVFILE))
	$(call copy_configs)
	@$(DOCKER_CMD) up -d

stop:
	@echo "== stop containers";
	@$(DOCKER_CMD) stop

restart:
	@echo "== restart containers";
	$(call check_env_file_exists,$(ENVFILE))
	$(call copy_configs)
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
