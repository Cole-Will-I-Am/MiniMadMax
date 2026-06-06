#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODEL_NAME="${MINIMADMAX_MODEL:-minimadmax:latest}"
MODEL_ALIAS="${MINIMADMAX_ALIAS:-MiniMadMax:latest}"
WRAPPER_TARGET="${MINIMADMAX_WRAPPER_TARGET:-/usr/local/bin/minimadmax}"

ollama pull minimax-m3:cloud
ollama create "$MODEL_NAME" -f "$ROOT_DIR/Modelfile"
ollama cp "$MODEL_NAME" "$MODEL_ALIAS"

install -m 0755 "$ROOT_DIR/bin/minimadmax" "$WRAPPER_TARGET"

echo "Installed $MODEL_NAME"
echo "Alias: $MODEL_ALIAS"
echo "Run: minimadmax"
echo "Prompt: minimadmax \"inspect this repo\""
