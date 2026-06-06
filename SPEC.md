# MiniMadMax Model Spec

## Base

- Base model: `minimax-m3:cloud`
- Local model name: `minimadmax:latest`
- Local alias: `MiniMadMax:latest`
- Intended direct command: `minimadmax`
- Codex CLI profile: `minimadmax`
- Codex CLI wrapper: `codex-minimadmax`

## Companion Model

- Base model: `nemotron-3-ultra:cloud`
- Local model name: `codex-nemotron:latest`
- Intended direct command: `codex-nemotron`
- Spec path: `models/codex-nemotron/Modelfile`
- Context: `262144`
- Use case: slower, deeper VPS engineering and infrastructure assistance
- Automation note: use `/api/generate` with `think:false` for clean output; plain `ollama run` may display visible `Thinking...` output.

## Ollama Parameters

```text
num_ctx 524288
num_predict 16384
temperature 0.2
top_p 0.95
top_k 40
repeat_penalty 1.05
```

## Capability Prompt

MiniMadMax is prompted as a high-autonomy VPS engineering model. It is told to:

- inspect before acting
- use `rg`, `gh`, HTTPS `git`, and scoped commits
- run relevant verification
- avoid destructive operations without explicit authorization
- never reveal or commit secrets
- give concrete commands when it is not running inside a tool-enabled host

Prompt source files:

```text
models/minimadmax/system.md
models/codex-nemotron/system.md
```

The generated Ollama Modelfiles are:

```text
Modelfile
models/codex-nemotron/Modelfile
```

Use this command after prompt/config edits:

```bash
rebuild-ollama-models [all|minimadmax|codex-nemotron|render]
```

Plain Ollama model sessions cannot persist their own changes. A tool-enabled agent can edit the source-controlled prompt files, rebuild the model, run smoke checks, and commit the result.

## Known VPS GitHub Context

- Local `gh` authentication exists for `Cole-Will-I-Am`.
- The Git credential helper is configured for HTTPS through `gh auth git-credential`.
- `Cole-Will-I-Am/MiniMadMax` is this model's spec repository.
- `Cole-Will-I-Am/new-lab` has been observed with admin access from the VPS through local `gh`.

No credential values are stored in this repository.

## Codex CLI Integration

The installed Codex profile lives at:

```text
~/.codex/minimadmax.config.toml
```

Profile contents:

```toml
model = "minimadmax:latest"
model_provider = "ollama"
oss_provider = "ollama"
model_context_window = 524288
```

Use it with:

```bash
codex --profile minimadmax
codex exec --profile minimadmax "inspect this repo"
codex-minimadmax
codex-minimadmax exec "inspect this repo"
```
