#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
docker build -t pi-sandbox -f Dockerfile.pi .
docker run --rm -it \
  -v "$PWD:/workspace" \
  -v pi-agent-home:/root/.pi/agent \
  -v "$HOME/projects/dotfiles/docker/pi-sandbox/models.json:/root/.pi/agent/models.json" \
  pi-sandbox
