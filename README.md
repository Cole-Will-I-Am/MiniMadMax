# MiniMadMax

MiniMadMax is an Ollama custom model built from `minimax-m3:cloud` for high-autonomy VPS engineering work.

This repository also tracks companion VPS Ollama cloud wrappers, currently `codex-nemotron:latest`.

## Install

```bash
./install.sh
```

This creates the local Ollama model:

```text
minimadmax:latest
MiniMadMax:latest
```

It also installs a VPS wrapper:

```bash
minimadmax
codex-nemotron
rebuild-ollama-models
```

## Run

Interactive:

```bash
minimadmax
```

One-shot prompt:

```bash
minimadmax "Summarize your VPS and GitHub operating assumptions without revealing secrets."
```

Direct Ollama call:

```bash
ollama run minimadmax:latest --think high
```

CodexNemotron clean one-shot call:

```bash
codex-nemotron "Summarize the current VPS model inventory."
```

Repo-style alias:

```bash
ollama run MiniMadMax:latest --think high
```

## Use With Codex CLI

The installer adds this Codex profile:

```text
~/.codex/minimadmax.config.toml
```

Start interactive Codex with MiniMadMax:

```bash
codex --profile minimadmax
```

Run Codex noninteractively with MiniMadMax:

```bash
codex exec --profile minimadmax "inspect this repo"
```

Convenience wrapper:

```bash
codex-minimadmax
codex-minimadmax exec "inspect this repo"
```

API call:

```bash
curl http://localhost:11434/api/chat -d '{
  "model": "minimadmax:latest",
  "messages": [
    {
      "role": "user",
      "content": "What can you do on this VPS?"
    }
  ],
  "think": "high",
  "options": {
    "temperature": 0.2,
    "num_ctx": 524288,
    "num_predict": 4096
  }
}'
```

## GitHub And VPS Access Notes

The VPS has local GitHub CLI authentication for `Cole-Will-I-Am`, and Git HTTPS credentials are configured through `gh auth git-credential`.

The model specs intentionally do not include token values, passwords, private keys, or other secret material. MiniMadMax is allowed to know that credentialed GitHub access exists on the VPS, but it must not print, store, or commit secrets.

Use HTTPS remotes for Git operations unless SSH host keys have been configured.

## Companion Model: CodexNemotron

`codex-nemotron:latest` is built from `nemotron-3-ultra:cloud` for slower, deeper VPS engineering work.

Files:

```text
models/codex-nemotron/Modelfile
models/codex-nemotron/README.md
bin/codex-nemotron
```

The plain Ollama CLI may show visible `Thinking...` output for Nemotron. The `codex-nemotron` wrapper uses `/api/generate` with `think:false` for clean one-shot output.

## Updating Model Prompts

The models cannot mutate themselves during a plain `ollama run` session. Their durable role/personality comes from source-controlled prompt files:

```text
models/minimadmax/system.md
models/codex-nemotron/system.md
```

To change a model's role or behavior, edit the relevant `system.md`, then rebuild:

```bash
rebuild-ollama-models minimadmax
rebuild-ollama-models codex-nemotron
```

Render Modelfiles without registering models:

```bash
rebuild-ollama-models render
```

This regenerates the Ollama Modelfile and runs `ollama create` for the selected model. Prompt/config changes should be committed to this repository so future sessions retain them.
