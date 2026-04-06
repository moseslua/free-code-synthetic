# free-code-synthetic

A lightweight wrapper that configures Claude Code to use [synthetic.new](https://synthetic.new)'s API instead of Anthropic's — enabling free, high-quality AI coding with models like **Kimi-K2.5-NVFP4**.

## What is this?

**free-code** is a drop-in replacement for `claude` that redirects all API calls to synthetic.new's Anthropic-compatible endpoint. You get:

- ✅ **Same Claude Code experience** — agents, skills, subagents, tools
- ✅ **Free/cheap AI models** — Kimi-K2.5, GLM-4, and more
- ✅ **No auth/login prompts** — direct API key auth
- ✅ **Privacy-first** — telemetry disabled by default

## Quick Start

```bash
# 1. Install Claude Code (if not already)
npm install -g @anthropic-ai/claude-code

# 2. Install free-code wrapper
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/free-code-synthetic/main/install.sh | bash

# 3. Configure your API key
export SYNTHETIC_API_KEY="syn_your_key_here"

# 4. Use it exactly like claude
free-code
```

## Manual Installation

```bash
# Download the wrapper
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/free-code-synthetic/main/free-code -o ~/.local/bin/free-code
chmod +x ~/.local/bin/free-code

# Set environment variables
export ANTHROPIC_AUTH_TOKEN="syn_your_key_here"
export ANTHROPIC_BASE_URL="https://api.synthetic.new/anthropic"

# Run
free-code
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `ANTHROPIC_AUTH_TOKEN` | *required* | Your synthetic.new API key |
| `ANTHROPIC_BASE_URL` | `https://api.synthetic.new/anthropic` | API endpoint |
| `ANTHROPIC_DEFAULT_OPUS_MODEL` | `hf:nvidia/Kimi-K2.5-NVFP4` | Model for complex tasks |
| `ANTHROPIC_DEFAULT_SONNET_MODEL` | `hf:nvidia/Kimi-K2.5-NVFP4` | Model for standard tasks |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL` | `hf:zai-org/GLM-4.7-Flash` | Model for quick tasks |
| `CLAUDE_CODE_SUBAGENT_MODEL` | `hf:nvidia/Kimi-K2.5-NVFP4` | Model for crew agents |
| `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` | `1` | Disable telemetry |

## My-Brain-Is-Full-Crew Integration

This wrapper pairs perfectly with **My-Brain-Is-Full-Crew** — a 21-agent research system:

```bash
# 1. Clone crew repo
cd ~/your-vault
git clone https://github.com/YOUR_USERNAME/My-Brain-Is-Full-Crew.git
cd My-Brain-Is-Full-Crew
bash scripts/launchme.sh

# 2. Use free-code instead of claude
cd ~/your-vault
free-code
> initialize the vault
```

## Available Models

See [synthetic.new/docs/api/models](https://synthetic.new/docs/api/models) for full list.

Popular choices:
- `hf:nvidia/Kimi-K2.5-NVFP4` — Best overall (default)
- `hf:moonshotai/Kimi-K2.5` — Alternative Kimi
- `hf:zai-org/GLM-4.7-Flash` — Fast, cheap

## How it Works

```
free-code (wrapper script)
    ↓
Sets environment variables
    ↓
Executes claude-code CLI
    ↓
API calls go to synthetic.new/anthropic
    ↓
Returns responses from Kimi/GLM models
```

The wrapper is transparent — Claude Code thinks it's talking to Anthropic, but the requests are proxied to synthetic.new.

## Documentation

- [synthetic.new Claude Code Guide](https://dev.synthetic.new/docs/guides/claude-code)
- [My-Brain-Is-Full-Crew](https://github.com/YOUR_USERNAME/My-Brain-Is-Full-Crew) — 21-agent research crew

## License

MIT — same as Claude Code
