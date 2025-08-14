# MCXboxBroadcast Standalone Development Guide

## Prerequisites

- **Java 21** (OpenJDK or Oracle JDK)
- **Microsoft/Xbox Live account** (for authentication)

## Quick Start

**Note: Development setup currently supports the standalone application only.**

1. **Clone and setup**
   ```bash
   git clone <repository-url>
   cd Broadcaster
   make install
   ```

2. **Start development with hot-reload**
   ```bash
   make dev
   ```

3. **Authenticate** with Microsoft when prompted (follow the browser link and enter the code)

## Development Commands

| Command | Description |
|---------|-------------|
| `make install` | Install Gradle dependencies |
| `make dev` | Start development server with hot-reload |
| `make build` | Build the application (shadowJar) |
| `make run` | Build and run the application once |
| `make clean` | Clean build artifacts |
| `make test` | Run tests |

## Project Structure

```
Broadcaster/
├── core/                           # Core MCXboxBroadcast library
│   └── src/main/java/             # Core Java source code
├── bootstrap/
│   ├── geyser/                    # Geyser plugin integration
│   └── standalone/                # Standalone application
│       ├── src/main/java/         # Standalone Java source code
│       ├── config.yml             # Configuration file (created during development)
│       ├── cache/                 # Runtime cache directory (created during development)
│       └── logs/                  # Log files (created during development)
├── build-logic/                   # Gradle build configuration
└── Makefile                       # Development commands
```

## Configuration

The application creates and reads `config.yml` in its working directory. This file contains session settings, server information, and feature toggles.

**Important:** During development, edit the config file at `bootstrap/standalone/config.yml` (this file is created automatically when you run `make dev`).

## Docker Build

You can build a Docker image:

```bash
# Build production Docker image
make docker-build

# Run the Docker container
make docker-run
```

The Docker image packages the standalone application with all dependencies for easy deployment.

## Architecture

- **Core Library**: Xbox Live integration and session management
- **Bootstrap Modules**: Different deployment methods (standalone app, Geyser plugin)
- **Configuration**: YAML-based settings in `config/config.yml`
- **Storage**: File-based token caching in `config/cache/`
