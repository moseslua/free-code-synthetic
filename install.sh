#!/usr/bin/env bash
# Install free-code-synthetic wrapper

set -e

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           free-code-synthetic Installer                      ║"
echo "║     Claude Code wrapper for synthetic.new API                ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Colors
if [[ -t 1 ]]; then
    GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'
    RED='\033[0;31m'; NC='\033[0m'
else
    GREEN=''; CYAN=''; YELLOW=''; RED=''; NC=''
fi

info()    { echo -e "${CYAN}>${NC} $*"; }
success() { echo -e "${GREEN}✓${NC} $*"; }
warn()    { echo -e "${YELLOW}!${NC} $*"; }

# Check for claude-code
if ! command -v claude &> /dev/null; then
    warn "Claude Code not found in PATH"
    info "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
fi

# Determine install location
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    INSTALL_DIR="$HOME/.local/bin"
elif [ -d "/usr/local/bin" ] && [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
fi

info "Installing to: $INSTALL_DIR"

# Download the wrapper
SCRIPT_URL="https://raw.githubusercontent.com/moseslua/free-code-synthetic/main/free-code"
if command -v curl &> /dev/null; then
    curl -fsSL "$SCRIPT_URL" -o "$INSTALL_DIR/free-code" 2>/dev/null || cp "$(dirname "$0")/free-code" "$INSTALL_DIR/free-code"
elif command -v wget &> /dev/null; then
    wget -q "$SCRIPT_URL" -O "$INSTALL_DIR/free-code" 2>/dev/null || cp "$(dirname "$0")/free-code" "$INSTALL_DIR/free-code"
else
    cp "$(dirname "$0")/free-code" "$INSTALL_DIR/free-code"
fi

chmod +x "$INSTALL_DIR/free-code"
success "Installed free-code wrapper"

# Create env file template
ENV_FILE="$HOME/.free-code-env"
if [ ! -f "$ENV_FILE" ]; then
    cat > "$ENV_FILE" <<'EOF'
# free-code-synthetic configuration
# Get your API key from: https://synthetic.new

export ANTHROPIC_AUTH_TOKEN=""
export ANTHROPIC_BASE_URL="https://api.synthetic.new/anthropic"

# Model configuration
export ANTHROPIC_DEFAULT_OPUS_MODEL="hf:nvidia/Kimi-K2.5-NVFP4"
export ANTHROPIC_DEFAULT_SONNET_MODEL="hf:nvidia/Kimi-K2.5-NVFP4"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="hf:zai-org/GLM-4.7-Flash"
export CLAUDE_CODE_SUBAGENT_MODEL="hf:nvidia/Kimi-K2.5-NVFP4"

# Privacy
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="1"
EOF
    success "Created template config: $ENV_FILE"
    warn "Please edit $ENV_FILE and add your API key"
fi

# Add to shell profile
SHELL_PROFILE=""
if [ -f "$HOME/.bashrc" ]; then
    SHELL_PROFILE="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
fi

if [ -n "$SHELL_PROFILE" ] && ! grep -q "free-code-env" "$SHELL_PROFILE" 2>/dev/null; then
    echo "" >> "$SHELL_PROFILE"
    echo "# free-code-synthetic configuration" >> "$SHELL_PROFILE"
    echo "[ -f ~/.free-code-env ] && source ~/.free-code-env" >> "$SHELL_PROFILE"
    success "Added config loader to $SHELL_PROFILE"
fi

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    Installation Complete!                    ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo ""
echo "  1. Edit ~/.free-code-env and add your API key:"
echo "     export ANTHROPIC_AUTH_TOKEN='syn_your_key_here'"
echo ""
echo "  2. Reload your shell or run: source ~/.free-code-env"
echo ""
echo "  3. Use free-code:"
echo "     free-code"
echo ""
echo "Docs: https://dev.synthetic.new/docs/guides/claude-code"
echo ""
