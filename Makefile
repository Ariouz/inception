DOCKER_COMPOSE_FILE= ./srcs/

all:
	@echo "Syntax: make up/stop/restart" 

up:
	cd $(DOCKER_COMPOSE_FILE) && docker compose up -d --build

stop:
	cd $(DOCKER_COMPOSE_FILE) && docker compose stop

down:
	cd $(DOCKER_COMPOSE_FILE) && docker compose down -v

restart:
	cd $(DOCKER_COMPOSE_FILE) && docker compose restart

build:
	docker build -t nginx ./srcs/requirements/nginx
	docker build -t wordpress ./srcs/requirements/wordpress
