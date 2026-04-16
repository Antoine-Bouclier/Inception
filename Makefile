DATA_PATH = /home/abouclie/data

GREEN = \033[0;32m
RED = \033[0;31m
RESET = \033[0m

all: up

up:
	@echo "$(GREEN)Creating data directories...$(RESET)"
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	@echo "$(GREEN)Building and starting containers...$(RESET)"
	@docker compose -f srcs/docker-compose.yml up -d --build

down:
	@echo "$(RED)Stopping and removing containers...$(RESET)"
	@docker compose -f srcs/docker-compose.yml down

start:
	@echo "$(GREEN)Starting existing containers...$(RESET)"
	@docker compose -f srcs/docker-compose.yml start

stop:
	@echo "$(RED)Stopping running containers...$(RESET)"
	@docker compose -f srcs/docker-compose.yml stop

fclean: down
	@echo "$(RED)Performing full cleanup...$(RESET)"
	@docker image prune -af --filter "label=project=inception"
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@echo "$(GREEN)Cleanup complete!$(RESET)"

re: fclean all

.PHONY: all up down start stop fclean re
