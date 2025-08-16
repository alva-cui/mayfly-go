# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Go-based web application called "mayfly-go" that provides a unified management platform for various DevOps operations. It includes:

- Linux system management (terminal, file management, scripts, process monitoring)
- Database management for multiple databases (MySQL, PostgreSQL, Oracle, SQL Server, etc.)
- Redis management (single, sentinel, cluster modes)
- MongoDB operations
- Elasticsearch management
- Workflow approval system

## Architecture

The project follows a modular architecture with a clear separation between frontend (Vue3) and backend (Go/Gin):

- **Frontend**: Vue3, TypeScript, Element Plus, Vite
- **Backend**: Go, Gin framework, GORM
- **Database Support**: SQLite (default), MySQL, PostgreSQL
- **Authentication**: JWT-based with role-based access control

### Backend Structure

The backend is organized in a modular way with each functional area in its own package under `server/internal/`:

- `auth/` - Authentication and authorization
- `db/` - Database management (multiple database types)
- `es/` - Elasticsearch management
- `machine/` - Linux machine operations (SSH, RDP, file management)
- `mongo/` - MongoDB operations
- `msg/` - Messaging system
- `redis/` - Redis operations
- `sys/` - System management (accounts, roles, resources)
- `tag/` - Tag-based resource organization
- `flow/` - Workflow/approval system

Each module follows a consistent pattern:
- `api/` - HTTP API handlers
- `application/` - Business logic layer
- `domain/` - Entity definitions and repository interfaces
- `infrastructure/` - Repository implementations
- `init/` - Module initialization

## Common Development Tasks

### Building and Running

**Backend Development:**
```bash
cd server
go run main.go
```

**Frontend Development:**
```bash
cd frontend
npm run dev
```

**Building for Production:**
```bash
# Frontend
cd frontend
npm run build

# Backend (from server directory)
go build -o mayfly-go main.go
```

**Docker Build (from source):**
```bash
docker build -f Dockerfile.sourcebuild -t mayfly-go .
```

### Configuration

The application is configured via `config.yml` (copy and modify `config.yml.example`). Key configuration sections:
- `server` - Web server settings (port, TLS, CORS)
- `mysql` - MySQL database connection (optional)
- `sqlite` - SQLite database path (default)
- `jwt` - Authentication settings
- `log` - Logging configuration

### Testing

The project uses Go's built-in testing framework. Tests can be run with:
```bash
go test ./...
```

### Database Migrations

Database migrations are handled automatically on startup. Migration files are located in `server/migration/migrations/`.

## Key Components

### IOC (Inversion of Control)

The project uses a custom IOC container for dependency injection. Components are registered in `init` functions and injected using struct tags like `inject:"T"`.

### Request Handling

HTTP requests are handled through a custom framework built on Gin. APIs implement the `RouterApi` interface and define their routes in the `ReqConfs()` method.

### Database Abstraction

The database module provides a unified interface for multiple database types through the `DbConn` struct, which wraps standard `sql.DB` with additional functionality for different database dialects.

### SSH/RDP Connections

Machine operations are handled through SSH connections managed by the `machine` module, with support for SSH tunneling and RDP connections through Guacamole.