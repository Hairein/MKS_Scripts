#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SQL_URL="https://raw.githubusercontent.com/Hairein/MKS_Scripts/main/setup_mksps_db.sql"
SQL_FILE="$SCRIPT_DIR/setup_mksps_db.sql"
COMPOSE_FILE="${COMPOSE_FILE:-$SCRIPT_DIR/docker-compose.yml}"
COMPOSE_SERVICE="${COMPOSE_SERVICE:-database}"
MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-my-secret-pw}"

download_sql() {
    if command -v wget >/dev/null 2>&1; then
        wget -q -O "$SQL_FILE" "$SQL_URL"
    elif command -v curl >/dev/null 2>&1; then
        curl -fsSL -o "$SQL_FILE" "$SQL_URL"
    else
        echo "Error: install wget or curl first." >&2
        exit 1
    fi
}

ensure_docker() {
    if ! command -v docker >/dev/null 2>&1; then
        echo "Error: Docker is not installed or not in PATH." >&2
        exit 1
    fi
}

ensure_compose_file() {
    if [[ ! -f "$COMPOSE_FILE" ]]; then
        echo "Error: compose file not found at $COMPOSE_FILE." >&2
        exit 1
    fi
}

wait_for_mysql() {
    local retries=30
    while [[ $retries -gt 0 ]]; do
        if docker compose -f "$COMPOSE_FILE" exec -T -e "MYSQL_PWD=$MYSQL_ROOT_PASSWORD" \
            "$COMPOSE_SERVICE" mysqladmin ping -h 127.0.0.1 -uroot --silent \
            >/dev/null 2>&1; then
            return
        fi
        sleep 2
        retries=$((retries - 1))
    done

    echo "Error: compose service $COMPOSE_SERVICE did not become ready in time." >&2
    exit 1
}

apply_sql() {
    docker compose -f "$COMPOSE_FILE" exec -T "$COMPOSE_SERVICE" \
        sh -c 'cat > /tmp/setup_mksps_db.sql' < "$SQL_FILE"
    docker compose -f "$COMPOSE_FILE" exec -T -e "MYSQL_PWD=$MYSQL_ROOT_PASSWORD" \
        "$COMPOSE_SERVICE" mysql -u root < /tmp/setup_mksps_db.sql
}

main() {
    ensure_docker
    download_sql
    ensure_compose_file

    if ! grep -q 'CREATE DATABASE `mks_ps_db`' "$SQL_FILE"; then
        echo "Warning: downloaded SQL does not contain the expected database name." >&2
    fi

    wait_for_mysql
    apply_sql

    echo "Database structure setup completed in compose service: $COMPOSE_SERVICE"
}

main "$@"