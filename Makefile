# MCXboxBroadcast Makefile (Multi-stage Docker Build)
# Variables
SERVICE_NAME = mcxboxbroadcast

# Default target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  standalone-build         - Build the service"
	@echo "  standalone-build-no-cache - Build the service without cache"
	@echo "  standalone-up            - Build and start the service"
	@echo "  standalone-up-interactive - Build and start service interactively"
	@echo "  standalone-up-watch      - Start with file watching for development"
	@echo "  standalone-down          - Stop and remove the service"
	@echo "  standalone-restart       - Restart the service"
	@echo "  standalone-logs          - Show logs from the service"
	@	echo "  standalone-logs-follow   - Follow logs from the service"
	@echo "  standalone-shell         - Open a shell in the container"
	@echo "  standalone-clean         - Remove containers, networks, and volumes"

# Build the service
.PHONY: standalone-build
standalone-build:
	@echo "Building MCXboxBroadcast service..."
	docker compose build

.PHONY: standalone-build-no-cache
standalone-build-no-cache:
	@echo "Building MCXboxBroadcast service without cache..."
	docker compose build --no-cache

# Start the service
.PHONY: standalone-up
standalone-up:
	@echo "Building and starting MCXboxBroadcast service..."
	docker compose up -d --build

# Start interactively
.PHONY: standalone-up-interactive
standalone-up-interactive:
	@echo "Building and starting MCXboxBroadcast service interactively..."
	docker compose up --build

# Start with file watching for development
.PHONY: standalone-up-watch
standalone-up-watch:
	@echo "Starting MCXboxBroadcast service with file watching..."
	docker compose up --watch

# Stop and remove the service
.PHONY: standalone-down
standalone-down:
	@echo "Stopping and removing MCXboxBroadcast service..."
	docker compose down

# Restart the service
.PHONY: standalone-restart
standalone-restart:
	@echo "Restarting MCXboxBroadcast service..."
	docker compose restart

# Show logs
.PHONY: standalone-logs
standalone-logs:
	docker compose logs

# Follow logs
.PHONY: standalone-logs-follow
standalone-logs-follow:
	docker compose logs -f

# Open a shell in the container
.PHONY: standalone-shell
standalone-shell:
	docker compose exec $(SERVICE_NAME) /bin/sh

# Clean up
.PHONY: standalone-clean
standalone-clean:
	@echo "Cleaning up containers, networks, and volumes..."
	docker compose down -v --remove-orphans
