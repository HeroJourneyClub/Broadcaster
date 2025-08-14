# Variables
IMAGE_NAME = mcxboxbroadcast-standalone

# Default target
.PHONY: help
help:
	@echo "Development:"
	@echo "  install                  - Install dependencies and prepare development environment"
	@echo "  dev                      - Start development server with hot reload"
	@echo "  build                    - Build the application"
	@echo "  run                      - Run the application (after building)"
	@echo "  clean                    - Clean build artifacts"
	@echo "  test                     - Run tests"
	@echo ""
	@echo "Production:"
	@echo "  docker-build             - Build production Docker image"
	@echo "  docker-build-no-cache    - Build production image without cache"
	@echo "  docker-run               - Run production container (one-time)"

# =============================================================================
# Development Targets
# =============================================================================

.PHONY: install
install:
	@echo "Installing dependencies..."
	./gradlew dependencies --no-daemon
	@echo "Dependencies installed successfully!"

.PHONY: dev
dev:
	@echo "Starting development server with hot reload..."
	./gradlew :bootstrap-standalone:run --continuous --no-daemon

.PHONY: build
build:
	@echo "Building application..."
	./gradlew :bootstrap-standalone:shadowJar --no-daemon

.PHONY: run
run: build
	@echo "Running application..."
	java -jar ./bootstrap/standalone/build/libs/MCXboxBroadcastStandalone.jar

.PHONY: stop
stop:
	@echo "Stopping application..."
	./gradlew --stop

.PHONY: clean
clean: stop
	@echo "Cleaning build artifacts..."
	./gradlew clean --no-daemon

.PHONY: clean-cache
clean-cache:
	@echo "Cleaning cache..."
	rm -rf ./bootstrap/standalone/cache

.PHONY: test
test:
	@echo "Running tests..."
	./gradlew test --no-daemon

# =============================================================================
# Docker Targets
# =============================================================================

.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE_NAME):latest -f ./bootstrap/standalone/Dockerfile .

.PHONY: docker-build-no-cache
docker-build-no-cache:
	docker build --no-cache -t $(IMAGE_NAME):latest -f ./bootstrap/standalone/Dockerfile .

.PHONY: docker-run
docker-run:
	docker run --rm -it -v ./config:/opt/app/config $(IMAGE_NAME):latest
