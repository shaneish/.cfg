#!/usr/bin/env bash

WORKSPACE_DIR="$(pwd)"
if [[ -n "${1:-}" ]]; then
  if [[ "$1" = "-h" || "$1" = "--help" ]]; then
    echo "Usage: $0 [workspace_directory]"
    exit 1
  fi
  WORKSPACE_DIR="$1"
fi

podman run --rm -it \
  --security-opt label=disable \
  -v "${WORKSPACE_DIR}":/workspace:Z \
  -v "$HOME/.cursor":/home/cursor-user/.cursor:Z \
  -e CURSOR_API_KEY="crsr_445adeabcb05cc5c30125c66da0e436062c5d79777e61a568e7309c40992f34b" \
  cursor-agent-local:latest
