#!/bin/bash

COMPOSE_DIR="$(dirname "$0")/node"

usage() {
    echo "Usage: $0 {start|stop|restart|status|logs|clean}"
    echo ""
    echo "Commands:"
    echo "  start    - Start Traefik and all apps (docker compose up --build -d)"
    echo "  stop     - Stop all containers (docker compose down)"
    echo "  restart  - Restart all containers"
    echo "  status   - Show running containers"
    echo "  logs     - Show logs from all containers"
    echo "  clean    - Stop and remove all containers, networks, and volumes"
    exit 1
}

case "${1:-}" in
    start)
        echo "Starting Traefik and apps..."
        cd "$COMPOSE_DIR" && docker compose up --build -d
        echo ""
        echo "Access URLs:"
        echo "  http://app1.local:70/  - App1"
        echo "  http://app2.local:70/  - App2"
        echo "  http://app3.local:70/  - App3"
        echo "  http://localhost:7070/ - Traefik Dashboard"
        ;;
    stop)
        echo "Stopping all containers..."
        cd "$COMPOSE_DIR" && docker compose down
        ;;
    restart)
        echo "Restarting all containers..."
        cd "$COMPOSE_DIR" && docker compose down && docker compose up --build -d
        ;;
    status)
        echo "Container status:"
        cd "$COMPOSE_DIR" && docker compose ps
        ;;
    logs)
        echo "Showing logs (Ctrl+C to exit)..."
        cd "$COMPOSE_DIR" && docker compose logs -f
        ;;
    clean)
        echo "Stopping and removing everything..."
        cd "$COMPOSE_DIR" && docker compose down -v --remove-orphans
        docker system prune -f
        ;;
    *)
        usage
        ;;
esac
