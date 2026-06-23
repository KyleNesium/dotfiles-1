#!/usr/bin/env bash
#
# Music Production Setup Installer
# ---------------------------------
# Restores the full Claude Code + Ableton Live music production setup on a fresh machine.
#
# What this installs:
#   - 14 Claude skills (ableton + ableton-lom + 12 glincker music skills)
#   - Local ableton-mcp fork (28 tools incl. master/return/device-param/chain-safe)
#   - Ableton Remote Script (Windows / WSL)
#   - Music-related memory files
#   - Claude Code config (MCP server + permission allowlist)
#
# Usage:
#   bash music-production/install.sh
#
# Idempotent — safe to run multiple times. Backs up existing files before overwriting.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

# ── colors ─────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; BLUE='\033[0;34m'; NC='\033[0m'

log()  { printf "${BLUE}==>${NC} %s\n" "$*"; }
ok()   { printf "${GREEN}OK${NC}  %s\n" "$*"; }
warn() { printf "${YELLOW}WARN${NC} %s\n" "$*"; }
err()  { printf "${RED}ERR${NC} %s\n" "$*" >&2; }

# ── prerequisites ──────────────────────────────────────────────────────────
log "Checking prerequisites..."
MISSING=()
for cmd in jq rsync git; do
  command -v "$cmd" >/dev/null 2>&1 || MISSING+=("$cmd")
done
if [ ${#MISSING[@]} -gt 0 ]; then
  err "Missing required commands: ${MISSING[*]}"
  err "On Ubuntu/WSL: sudo apt install ${MISSING[*]}"
  err "On macOS: brew install ${MISSING[*]}"
  exit 1
fi

# uv is optional but needed to run the MCP fork
if ! command -v uv >/dev/null 2>&1 && [ ! -x "$HOME/.local/bin/uv" ]; then
  warn "uv not found — needed to run the ableton-mcp fork."
  warn "Install: curl -LsSf https://astral.sh/uv/install.sh | sh"
  warn "Continuing anyway — install later before using the MCP."
fi

# ── platform detection ─────────────────────────────────────────────────────
PLATFORM="unknown"
case "$(uname -s)" in
  Linux*)
    if grep -qi microsoft /proc/version 2>/dev/null; then PLATFORM="wsl"; else PLATFORM="linux"; fi
    ;;
  Darwin*) PLATFORM="mac" ;;
esac
log "Platform: $PLATFORM"

# ── 1. Install Claude skills ───────────────────────────────────────────────
log "Installing Claude skills to ~/.claude/skills/..."
mkdir -p "$HOME/.claude/skills"

SKILLS_INSTALLED=0
for skill_dir in "$SCRIPT_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  target="$HOME/.claude/skills/$skill_name"
  if [ -d "$target" ] && [ ! -L "$target" ]; then
    backup="$target.bak-$TIMESTAMP"
    log "  $skill_name exists — backing up to $(basename "$backup")"
    mv "$target" "$backup"
  fi
  rsync -a "$skill_dir" "$target/"
  SKILLS_INSTALLED=$((SKILLS_INSTALLED + 1))
done
ok "Installed $SKILLS_INSTALLED skills"

# ── 2. Install MCP fork ────────────────────────────────────────────────────
log "Installing ableton-mcp fork to ~/workspace/ableton-mcp/..."
mkdir -p "$HOME/workspace"
MCP_TARGET="$HOME/workspace/ableton-mcp"

if [ -d "$MCP_TARGET" ]; then
  if [ -d "$MCP_TARGET/.git" ]; then
    log "  Existing git repo found — preserving .git, updating source files"
    rsync -a --exclude='.git' "$SCRIPT_DIR/mcp-fork/" "$MCP_TARGET/"
  else
    backup="$MCP_TARGET.bak-$TIMESTAMP"
    log "  Non-git copy found — backing up to $(basename "$backup")"
    mv "$MCP_TARGET" "$backup"
    rsync -a "$SCRIPT_DIR/mcp-fork/" "$MCP_TARGET/"
  fi
else
  rsync -a "$SCRIPT_DIR/mcp-fork/" "$MCP_TARGET/"
fi

# Initialize git if not present (clone from upstream history)
if [ ! -d "$MCP_TARGET/.git" ]; then
  log "  Initializing git in MCP fork..."
  (cd "$MCP_TARGET" && git init -q && git add . && git commit -q -m "Initial commit from dotfiles" 2>/dev/null) || warn "  git init failed (non-fatal)"
fi
ok "MCP fork at $MCP_TARGET"

# ── 3. Install Remote Script (WSL only) ────────────────────────────────────
if [ "$PLATFORM" = "wsl" ]; then
  log "Looking for Ableton Live install..."

  ABLETON_PATHS=(
    "/mnt/c/ProgramData/Ableton/Live125suite/Resources/MIDI Remote Scripts"
    "/mnt/c/ProgramData/Ableton/Live12suite/Resources/MIDI Remote Scripts"
    "/mnt/c/ProgramData/Ableton/Live125trial/Resources/MIDI Remote Scripts"
    "/mnt/c/ProgramData/Ableton/Live125std/Resources/MIDI Remote Scripts"
    "/mnt/c/ProgramData/Ableton/Live124suite/Resources/MIDI Remote Scripts"
  )
  ABLETON_DIR=""
  for p in "${ABLETON_PATHS[@]}"; do
    if [ -d "$p" ]; then ABLETON_DIR="$p"; break; fi
  done

  # Fallback: glob search
  if [ -z "$ABLETON_DIR" ]; then
    ABLETON_DIR=$(find /mnt/c/ProgramData/Ableton -maxdepth 4 -type d -name "MIDI Remote Scripts" 2>/dev/null | head -1)
  fi

  if [ -n "$ABLETON_DIR" ]; then
    TARGET="$ABLETON_DIR/AbletonMCP"
    mkdir -p "$TARGET"
    cp "$SCRIPT_DIR/remote-script/__init__.py" "$TARGET/__init__.py"
    ok "Remote Script installed: $TARGET/__init__.py"
    echo "    NEXT STEPS in Ableton:"
    echo "    1. Restart Ableton Live"
    echo "    2. Preferences → Link, Tempo & MIDI → Control Surface"
    echo "    3. Select 'AbletonMCP' in any dropdown slot"
    echo "    4. Status bar should show: 'AbletonMCP: Listening for commands on port 9877'"
  else
    warn "No Ableton Live install found under /mnt/c/ProgramData/Ableton/"
    warn "Skipping Remote Script deploy. Install Ableton first, then re-run this script."
  fi
elif [ "$PLATFORM" = "mac" ]; then
  log "On macOS, install Remote Script manually:"
  echo "    Copy: $SCRIPT_DIR/remote-script/__init__.py"
  echo "    To:   ~/Music/Ableton/User Library/Remote Scripts/AbletonMCP/"
  echo "    (Create the AbletonMCP directory first)"
else
  log "Non-WSL platform — Remote Script must be deployed manually to Ableton's User Remote Scripts directory"
fi

# ── 4. Install memory files ────────────────────────────────────────────────
log "Installing memory files..."
MEM_DIR="$HOME/.claude/projects/-home-kyle/memory"
mkdir -p "$MEM_DIR"

for f in "$SCRIPT_DIR/memory"/*.md; do
  base=$(basename "$f")
  target="$MEM_DIR/$base"
  if [ -f "$target" ]; then
    log "  $base exists — replacing (backup at $target.bak-$TIMESTAMP)"
    cp "$target" "$target.bak-$TIMESTAMP"
  fi
  cp "$f" "$target"
done

# Update MEMORY.md index if it exists
if [ -f "$MEM_DIR/MEMORY.md" ]; then
  log "  Adding music-related memory entries to MEMORY.md..."
  for f in "$SCRIPT_DIR/memory"/*.md; do
    base=$(basename "$f" .md)
    # Skip if line already present
    if ! grep -q "($base.md)" "$MEM_DIR/MEMORY.md"; then
      desc=$(grep -m 1 '^description:' "$f" | sed 's/description: //')
      echo "- [$base]($base.md) — $desc" >> "$MEM_DIR/MEMORY.md"
    fi
  done
else
  log "  Creating new MEMORY.md..."
  {
    for f in "$SCRIPT_DIR/memory"/*.md; do
      base=$(basename "$f" .md)
      desc=$(grep -m 1 '^description:' "$f" | sed 's/description: //')
      echo "- [$base]($base.md) — $desc"
    done
  } > "$MEM_DIR/MEMORY.md"
fi
ok "Memory files installed at $MEM_DIR"

# ── 5. Merge MCP server config into ~/.claude.json ─────────────────────────
log "Merging MCP server config into ~/.claude.json..."
CLAUDE_JSON="$HOME/.claude.json"

if [ ! -f "$CLAUDE_JSON" ]; then
  log "  Creating ~/.claude.json..."
  echo '{}' > "$CLAUDE_JSON"
fi

cp "$CLAUDE_JSON" "$CLAUDE_JSON.bak-$TIMESTAMP"
jq -s '.[0] * .[1]' "$CLAUDE_JSON" "$SCRIPT_DIR/claude-config/mcp-server.json" > "$CLAUDE_JSON.new"
mv "$CLAUDE_JSON.new" "$CLAUDE_JSON"
ok "MCP server config merged (backup: $(basename "$CLAUDE_JSON.bak-$TIMESTAMP"))"

# ── 6. Merge permissions into settings.local.json ──────────────────────────
log "Merging music permissions into ~/.claude/settings.local.json..."
SETTINGS="$HOME/.claude/settings.local.json"

if [ ! -f "$SETTINGS" ]; then
  log "  Creating settings.local.json..."
  echo '{"permissions":{"allow":[]}}' > "$SETTINGS"
fi

cp "$SETTINGS" "$SETTINGS.bak-$TIMESTAMP"
# Merge: union existing + new allow array, deduplicate
jq --slurpfile new "$SCRIPT_DIR/claude-config/permissions.json" '
  .permissions.allow = (.permissions.allow + $new[0].permissions.allow | unique)
' "$SETTINGS" > "$SETTINGS.new"
mv "$SETTINGS.new" "$SETTINGS"
ok "Permissions merged (backup: $(basename "$SETTINGS.bak-$TIMESTAMP"))"

# ── 7. Final summary ───────────────────────────────────────────────────────
echo
ok "Music production setup installed."
echo
echo "Summary:"
echo "  Skills:           ~/.claude/skills/ ($SKILLS_INSTALLED installed)"
echo "  MCP fork:         ~/workspace/ableton-mcp/"
echo "  Memory files:     $MEM_DIR"
echo "  Claude config:    ~/.claude.json (MCP server) + settings.local.json (permissions)"
if [ "$PLATFORM" = "wsl" ] && [ -n "${ABLETON_DIR:-}" ]; then
  echo "  Remote Script:    $ABLETON_DIR/AbletonMCP/"
fi
echo
log "NEXT STEPS:"
echo "  1. Install uv if missing: curl -LsSf https://astral.sh/uv/install.sh | sh"
echo "  2. (WSL/Windows) Restart Ableton + select AbletonMCP as Control Surface"
echo "  3. Restart Claude Code (/exit + claude) to pick up new MCP server"
echo "  4. Verify: ask Claude 'list ableton MCP tools' — you should see 28 tools"
echo
echo "Documentation:"
echo "  Setup overview:   $SCRIPT_DIR/README.md"
echo "  Brand bedrock:    ~/.claude/skills/ableton/identity/ARTIST-PROFILE.md"
echo "  Genre reference:  ~/.claude/skills/ableton/genres/INDEX.md"
echo "  MCP tool guide:   ~/.claude/skills/ableton/MCP-CAPABILITIES.md"
