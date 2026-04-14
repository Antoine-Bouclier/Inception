DATA_PATH = /home/abouclie/data

GREEN = \033[0;32m
RED = \033[0;31m
RESET = \033[0m

all: up

up:
	@echo "$(GREEN)Création des dossiers de données...$(RESET)"
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	@echo "$(GREEN)Lancement des conteneurs...$(RESET)"
	@docker compose -f srcs/docker-compose.yml up -d --build

down:
	@echo "$(RED)Arrêt des conteneurs...$(RESET)"
	@docker compose -f srcs/docker-compose.yml down

start:
	@echo "$(GREEN)Démarrage des conteneurs existants...$(RESET)"
	@docker compose -f srcs/docker-compose.yml start

stop:
	@echo "$(RED)Arrêt des conteneurs...$(RESET)"
	@docker compose -f srcs/docker-compose.yml stop

fclean: down
	@echo "$(RED)Nettoyage complet en cours...$(RESET)"
	@docker system prune -af
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@echo "$(GREEN)Tout est propre !$(RESET)"

re: fclean all

.PHONY: all up down start stop fclean re
