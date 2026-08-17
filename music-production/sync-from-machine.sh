#!/usr/bin/env bash
#
# Sync FROM the current machine's working music setup INTO this dotfiles directory.
# Run this when you've made changes you want to back up.
# Opposite direction of install.sh.

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[0;33m'; NC='\033[0m'
log() { printf "${BLUE}==>${NC} %s\n" "$*"; }
ok()  { printf "${GREEN}OK${NC}  %s\n" "$*"; }
warn(){ printf "${YELLOW}WARN${NC} %s\n" "$*"; }

# ── 1. Skills ──────────────────────────────────────────────────────────────
log "Syncing skills from ~/.claude/skills/ → music-production/skills/"
SKILLS=(ableton ableton-lom arrangement-coach chord-pro groove-builder mastering-prep midi-cleanup mixer-doctor producer-mode reference-match sidechain-setup sound-designer tempo-coach vocal-chain)
for s in "${SKILLS[@]}"; do
  src="$HOME/.claude/skills/$s"
  if [ -d "$src" ]; then
    rsync -a --delete --exclude='.git' --exclude='.github' --exclude='__pycache__' --exclude='*.pyc' \
      "$src/" "$SCRIPT_DIR/skills/$s/"
  else
    warn "  $s not found at $src — skipped"
  fi
done
ok "Skills synced"

# ── 2. MCP fork ────────────────────────────────────────────────────────────
log "Syncing MCP fork from ~/workspace/ableton-mcp/ → music-production/mcp-fork/"
if [ -d "$HOME/workspace/ableton-mcp" ]; then
  rsync -a --delete \
    --exclude='.git' --exclude='.github' --exclude='.venv' \
    --exclude='node_modules' --exclude='__pycache__' \
    --exclude='*.pyc' --exclude='uv.lock' --exclude='.python-version' \
    "$HOME/workspace/ableton-mcp/" "$SCRIPT_DIR/mcp-fork/"
  ok "MCP fork synced ($(du -sh "$SCRIPT_DIR/mcp-fork" | cut -f1))"
else
  warn "MCP fork not found at ~/workspace/ableton-mcp/ — skipped"
fi

# ── 3. Remote Script ───────────────────────────────────────────────────────
log "Snapshotting Remote Script..."
ABLETON_PATHS=(
  "/mnt/c/ProgramData/Ableton/Live125suite/Resources/MIDI Remote Scripts/AbletonMCP/__init__.py"
  "/mnt/c/ProgramData/Ableton/Live124suite/Resources/MIDI Remote Scripts/AbletonMCP/__init__.py"
  "$HOME/Music/Ableton/User Library/Remote Scripts/AbletonMCP/__init__.py"
)
FOUND=""
for p in "${ABLETON_PATHS[@]}"; do
  if [ -f "$p" ]; then FOUND="$p"; break; fi
done
# Glob fallback for WSL
if [ -z "$FOUND" ] && [ -d /mnt/c/ProgramData/Ableton ]; then
  FOUND=$(find /mnt/c/ProgramData/Ableton -maxdepth 5 -path "*/AbletonMCP/__init__.py" 2>/dev/null | head -1)
fi

if [ -n "$FOUND" ]; then
  cp "$FOUND" "$SCRIPT_DIR/remote-script/__init__.py"
  ok "Remote Script snapshot from $FOUND"
else
  warn "Remote Script not found — skipped"
fi

# ── 4. Memory files ────────────────────────────────────────────────────────
log "Syncing music-related memory files..."
MEM_SRC="$HOME/.claude/projects/-home-kyle/memory"
if [ -d "$MEM_SRC" ]; then
  MEMS=(feedback_diva_unlicensed project_ableton_mcp_fork project_ableton_mcp_install project_kyle_artist_identity project_music_library)
  for m in "${MEMS[@]}"; do
    if [ -f "$MEM_SRC/$m.md" ]; then
      cp "$MEM_SRC/$m.md" "$SCRIPT_DIR/memory/"
    fi
  done
  ok "Memory files synced"
fi

# ── 5. Claude config snippets ──────────────────────────────────────────────
log "Re-extracting Claude config snippets..."
if [ -f "$HOME/.claude.json" ]; then
  jq '{mcpServers: {ableton: .mcpServers.ableton}}' "$HOME/.claude.json" > "$SCRIPT_DIR/claude-config/mcp-server.json"
  ok "MCP server config extracted"
fi

if [ -f "$HOME/.claude/settings.local.json" ]; then
  jq '{permissions: {allow: [.permissions.allow[] | select(. | test("ableton|music|native-instruments|ahujasid|update-config|producer-mode|mixer-doctor|midi-cleanup|reference-match|groove-builder|chord-pro|arrangement-coach|tempo-coach|sound-designer|sidechain-setup|mastering-prep|vocal-chain"))]}}' "$HOME/.claude/settings.local.json" > "$SCRIPT_DIR/claude-config/permissions.json"
  ok "Permissions extracted"
fi

# ── Summary ────────────────────────────────────────────────────────────────
echo
ok "Sync complete. Total size: $(du -sh "$SCRIPT_DIR" | cut -f1)"
echo
log "Review changes with: git -C $SCRIPT_DIR/.. diff music-production/"
log "Commit with:         git -C $SCRIPT_DIR/.. add music-production/ && git commit -m 'music-production: sync'"
