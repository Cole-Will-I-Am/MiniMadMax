# MiniMadMax

MiniMadMax is an Ollama custom model built from `minimax-m3:cloud` for high-autonomy VPS engineering work.

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

Repo-style alias:

```bash
ollama run MiniMadMax:latest --think high
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
