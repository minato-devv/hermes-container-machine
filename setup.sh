#!/bin/bash

# Create data directory
DATA_DIRECTORY="${HOME}/.hermes"
HERMES_DASHBOARD_HOST="0.0.0.0"
mkdir -p "${DATA_DIRECTORY}"

echo "Starting container system..."

container system start

container image pull nousresearch/hermes-agent

container run --rm --interactive --tty \
	nousresearch/hermes-agent setup

echo "Running in gateway mode..."

container run --detach \
	--name hermes \
	--memory 4G \
	--cpus 2 \
	--volume "${DATA_DIRECTORY}:/opt/data" \
	--port "127.0.0.1:8642:8642" \
	--port "127.0.0.1:9119:9119" \
	--environment HERMES_DASHBOARD=1 \
	--environment HERMES_DASHBOARD_HOST="${HERMES_DASHBOARD_HOST:-0.0.0.0}" \
	nousresearch/hermes-agent gateway run

echo "Running interactive TUI..."

container exec --interactive --tty hermes /opt/hermes/.venv/bin/hermes --tui
