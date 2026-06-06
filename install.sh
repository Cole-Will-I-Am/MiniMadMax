#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODEL_NAME="${MINIMADMAX_MODEL:-minimadmax:latest}"
MODEL_ALIAS="${MINIMADMAX_ALIAS:-MiniMadMax:latest}"
WRAPPER_TARGET="${MINIMADMAX_WRAPPER_TARGET:-/usr/local/bin/minimadmax}"
CODEX_PROFILE_TARGET="${MINIMADMAX_CODEX_PROFILE_TARGET:-${CODEX_HOME:-$HOME/.codex}/minimadmax.config.toml}"
CODEX_WRAPPER_TARGET="${MINIMADMAX_CODEX_WRAPPER_TARGET:-/usr/local/bin/codex-minimadmax}"

ollama pull minimax-m3:cloud
ollama create "$MODEL_NAME" -f "$ROOT_DIR/Modelfile"
ollama cp "$MODEL_NAME" "$MODEL_ALIAS"

install -m 0755 "$ROOT_DIR/bin/minimadmax" "$WRAPPER_TARGET"
install -d "$(dirname "$CODEX_PROFILE_TARGET")"
install -m 0644 "$ROOT_DIR/codex/minimadmax.config.toml" "$CODEX_PROFILE_TARGET"
install -m 0755 "$ROOT_DIR/bin/codex-minimadmax" "$CODEX_WRAPPER_TARGET"

echo "Installed $MODEL_NAME"
echo "Alias: $MODEL_ALIAS"
echo "Run: minimadmax"
echo "Prompt: minimadmax \"inspect this repo\""
echo "Codex profile: codex --profile minimadmax"
echo "Codex wrapper: codex-minimadmax"
