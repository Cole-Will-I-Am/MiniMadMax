#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODEL_NAME="${MINIMADMAX_MODEL:-minimadmax:latest}"
MODEL_ALIAS="${MINIMADMAX_ALIAS:-MiniMadMax:latest}"
CODEX_NEMOTRON_MODEL="${CODEX_NEMOTRON_MODEL:-codex-nemotron:latest}"
WRAPPER_TARGET="${MINIMADMAX_WRAPPER_TARGET:-/usr/local/bin/minimadmax}"
CODEX_NEMOTRON_WRAPPER_TARGET="${CODEX_NEMOTRON_WRAPPER_TARGET:-/usr/local/bin/codex-nemotron}"
CODEX_PROFILE_TARGET="${MINIMADMAX_CODEX_PROFILE_TARGET:-${CODEX_HOME:-$HOME/.codex}/minimadmax.config.toml}"
CODEX_WRAPPER_TARGET="${MINIMADMAX_CODEX_WRAPPER_TARGET:-/usr/local/bin/codex-minimadmax}"

"$ROOT_DIR/bin/rebuild-ollama-models" render

ollama pull minimax-m3:cloud
ollama create "$MODEL_NAME" -f "$ROOT_DIR/Modelfile"
ollama cp "$MODEL_NAME" "$MODEL_ALIAS"
ollama pull nemotron-3-ultra:cloud
ollama create "$CODEX_NEMOTRON_MODEL" -f "$ROOT_DIR/models/codex-nemotron/Modelfile"

install -m 0755 "$ROOT_DIR/bin/minimadmax" "$WRAPPER_TARGET"
install -m 0755 "$ROOT_DIR/bin/codex-nemotron" "$CODEX_NEMOTRON_WRAPPER_TARGET"
install -m 0755 "$ROOT_DIR/bin/rebuild-ollama-models" "${REBUILD_OLLAMA_MODELS_TARGET:-/usr/local/bin/rebuild-ollama-models}"
install -m 0755 "$ROOT_DIR/bin/model-outcome" "${MODEL_OUTCOME_TARGET:-/usr/local/bin/model-outcome}"
install -m 0755 "$ROOT_DIR/bin/model-json-extract" "${MODEL_JSON_EXTRACT_TARGET:-/usr/local/bin/model-json-extract}"
install -d "$(dirname "$CODEX_PROFILE_TARGET")"
install -m 0644 "$ROOT_DIR/codex/minimadmax.config.toml" "$CODEX_PROFILE_TARGET"
install -m 0755 "$ROOT_DIR/bin/codex-minimadmax" "$CODEX_WRAPPER_TARGET"

echo "Installed $MODEL_NAME"
echo "Alias: $MODEL_ALIAS"
echo "Run: minimadmax"
echo "Installed $CODEX_NEMOTRON_MODEL"
echo "Run: codex-nemotron"
echo "Rebuild prompts/config: rebuild-ollama-models [all|minimadmax|codex-nemotron|render]"
echo "Record outcomes: model-outcome record --model minimadmax --task coding --outcome success"
echo "Extract model JSON: model-json-extract < output.txt"
echo "Prompt: minimadmax \"inspect this repo\""
echo "Codex profile: codex --profile minimadmax"
echo "Codex wrapper: codex-minimadmax"
