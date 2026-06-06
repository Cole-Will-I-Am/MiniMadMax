# MiniMadMax Model Spec

## Base

- Base model: `minimax-m3:cloud`
- Local model name: `minimadmax:latest`
- Local alias: `MiniMadMax:latest`
- Intended direct command: `minimadmax`

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

## Known VPS GitHub Context

- Local `gh` authentication exists for `Cole-Will-I-Am`.
- The Git credential helper is configured for HTTPS through `gh auth git-credential`.
- `Cole-Will-I-Am/MiniMadMax` is this model's spec repository.
- `Cole-Will-I-Am/new-lab` has been observed with admin access from the VPS through local `gh`.

No credential values are stored in this repository.
