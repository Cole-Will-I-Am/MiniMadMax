# CodexNemotron

CodexNemotron is an Ollama custom cloud wrapper built from `nemotron-3-ultra:cloud` for slower, deeper VPS engineering work.

## Install

From the repository root:

```bash
ollama create codex-nemotron:latest -f models/codex-nemotron/Modelfile
```

The top-level installer also creates this model and installs the `codex-nemotron` wrapper.

## Run

Codex profile wrapper:

```bash
codex-nemotron
codex-nemotron "Summarize the current VPS model inventory."
codex-nemotron exec "inspect this repo"
```

Direct Ollama CLI:

```bash
ollama run codex-nemotron:latest
```

Use the API example below when you need raw model output outside Codex.

## API Example

```bash
curl http://127.0.0.1:11434/api/generate -d '{
  "model": "codex-nemotron:latest",
  "prompt": "Reply with only: codex-nemotron ready",
  "stream": false,
  "think": false
}'
```

## Base

- Base model: `nemotron-3-ultra:cloud`
- Local model name: `codex-nemotron:latest`
- Context: `262144`
- Capabilities observed: `completion`, `thinking`, `tools`
