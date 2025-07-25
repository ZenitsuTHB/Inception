# ================== #
# Inception Makefile #
# ================== #

DOCKER := docker
COMPOSE := $(DOCKER) compose

COMPOSE_FILE := -f ./srcs/docker-compose.yml

DATA_ROOT := /home/$(USER)/data
DB_VOLUME := $(DATA_ROOT)/db
WP_VOLUME := $(DATA_ROOT)/wp

# =====================
# Main Targets
# =====================

all: up

# Build containers
build:
	@echo "🚀 Building containers..."
	$(COMPOSE) $(COMPOSE_FILE) build

# Start all services
up: ensure-volumes
	@echo "🔼 Starting services..."
	$(COMPOSE) $(COMPOSE_FILE) up -d

# Stop and remove containers
stop:
	@echo "🔽 Stopping services..."
	$(COMPOSE) $(COMPOSE_FILE) down

# Rebuild project
re: stop build up

# Ensure volumes exist
ensure-volumes:
	@echo "📂 Ensuring data volumes..."
	mkdir -p $(DB_VOLUME) $(WP_VOLUME)

# Delete all docker images
clean-images:
	@echo "🗑️ Removing all Docker images..."
	$(DOCKER) rmi -f $$(docker images -q)

# Full system prune
clean: stop
	@echo "🧹 Performing deep cleanup..."
	$(DOCKER) system prune -a -f --volumes

# Show status of containers and images
status:
	@echo "📊 Docker container status:"
	@$(DOCKER) ps
	@echo "\n\n📦 Docker images:"
	@$(DOCKER) images

# =====================
# Phony Declarations
# =====================
.PHONY: all build up stop re ensure-volumes clean-images clean status

