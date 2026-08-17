# Music Production Setup

Portable backup of Kyle's complete Claude Code + Ableton Live music production setup. Restore on any fresh machine with `bash install.sh`.

## What's in this directory

```
music-production/
├── README.md             ← this file
├── install.sh            ← one-command restore
├── skills/               ← 14 Claude skills
│   ├── ableton/          ← the parent skill (artist identity, genres, samples, MCP capabilities)
│   ├── ableton-lom/      ← Live Object Model API reference (mikecfisher/ableton-lom-skill)
│   ├── arrangement-coach/
│   ├── chord-pro/
│   ├── groove-builder/
│   ├── mastering-prep/
│   ├── midi-cleanup/
│   ├── mixer-doctor/
│   ├── producer-mode/
│   ├── reference-match/
│   ├── sidechain-setup/
│   ├── sound-designer/
│   ├── tempo-coach/
│   └── vocal-chain/
├── mcp-fork/             ← local ableton-mcp fork (28 tools — adds returns, master FX, device params, chain-safe append)
├── remote-script/        ← AbletonMCP Remote Script (1533-line __init__.py)
├── memory/               ← 5 cross-session memory files
└── claude-config/
    ├── mcp-server.json   ← MCP server registration snippet
    └── permissions.json  ← music-related permission allowlist
```

## Quick install (on a fresh machine)

```bash
# Clone dotfiles if not already
git clone https://github.com/KyleNesium/dotfiles-1.git ~/dotfiles
cd ~/dotfiles

# Run the music-production installer
bash music-production/install.sh
```

The installer:

1. Copies 14 skills to `~/.claude/skills/`
2. Copies MCP fork to `~/workspace/ableton-mcp/`
3. (WSL only) Deploys Remote Script to Ableton's `ProgramData` install
4. Copies memory files to `~/.claude/projects/-home-kyle/memory/`
5. Merges MCP server config into `~/.claude.json` (preserves existing config)
6. Merges music permissions into `~/.claude/settings.local.json` (preserves existing)
7. Backs up everything it touches with `.bak-YYYYMMDD-HHMMSS` suffix

## What this restores

### The Ableton MCP integration

A **custom fork** of the community `ahujasid/ableton-mcp` server with 7 added tools:

- `create_return_track(name)`
- `set_track_volume(track, value, track_type)` — regular / return / master
- `set_track_panning(track, value, track_type)`
- `set_send_level(track, send_idx, value, track_type)`
- `set_device_parameter(track, device, param, value, track_type)`
- `get_device_parameters(track, device, track_type)`
- `add_effect_to_track(track, uri, track_type)` — chain-safe (appends, doesn't replace)

Total: 28 MCP tools across the Remote Script + Python server.

### The skills layer

13 production skills from [glincker/ableton-skills](https://github.com/glincker/ableton-skills):
- producer-mode, mixer-doctor, mastering-prep, midi-cleanup, sidechain-setup
- chord-pro, groove-builder, arrangement-coach, tempo-coach
- reference-match, sound-designer, vocal-chain

Plus [mikecfisher/ableton-lom-skill](https://github.com/mikecfisher/ableton-lom-skill) — Live Object Model API reference for extending the MCP further.

### The Ableton parent skill (the brain)

`skills/ableton/` contains the entire personalised context:

- **`CLAUDE.md`** — co-producer ethos + gear inventory (Diva, Serum 2, DUNE 3, FabFilter suite, full Valhalla rack, Polyverse, polydigm Klimper, _Futurephonic Rhythmizer Ultra)
- **`REFERENCE-SET.md`** — Kyle's DJ set tracklist (46 tracks) + 8-subgenre taxonomy + structural canon + 6 canonical reference tracks beyond the set
- **`SAMPLES.md`** — full inventory of 60k+ WAVs / 1,324 MIDIs / 641 Serum presets / 334 Diva presets across 70+ commercial packs at `D:\Presets, Samples and Loops`, with creative usage playbook
- **`MCP-CAPABILITIES.md`** — what the MCP can/can't do, gotchas, workflow patterns
- **`genres/`** — 22 genre reference docs:
  - 13 harvested from [bitwize-music-studio](https://github.com/bitwize-music-studio/claude-ai-music-skills) (afro-house, breakbeat, deep-house, deep-techno, downtempo, drum-and-bass, dub-techno, minimal-techno, progressive-house, psy-trance, tech-house, techno, plus afro-house redundant)
  - 9 written from scratch (afro-tech, desert-tech, melodic-house, indie-dance, melodic-techno, organic-house, progressive-psy-trance, hard-groove, tribal-techno)
- **`identity/`** — Kyle's artist brand layer:
  - `ARTIST-PROFILE.md` — bedrock (producer name, tempo/key defaults, naming, LUFS, save paths, cross-genre calendar)
  - `PRODUCER-TAG.md` — 1.5s audio signature design protocol (whispered "Kyle" + reverse-reverb tail)
  - `SIGNATURE-MOVE.md` — "the breath" (reverse noise swell, 1 bar before every section change)
  - `SOUND-BANK.md` — 10-patch manifest (K-001 through K-010) across Drift/Serum 2/Wavetable/Analog/Operator
  - `MASTER-CHAIN.md` — exact spec for Pro-Q 4 → Pro-C 2 → Saturn 2 → Pro-L 2
  - `sound-bank-protocol.md` — how to design each patch via `set_device_parameter`
  - `master-chain-deploy.md` — one-call sequence to deploy master chain
  - `MOMENTS-LIBRARY.md` — annotated reference log (seeded with 6 entries from the set)

### Memory files (cross-session knowledge)

- `feedback_diva_unlicensed.md` — Diva is installed but not licensed; substitute with Drift/Analog/Wavetable
- `project_ableton_mcp_install.md` — Remote Script must go to `ProgramData/Live125suite/Resources/MIDI Remote Scripts/` (User Remote Scripts is silently ignored by Live 12.2.5)
- `project_ableton_mcp_fork.md` — local fork at `~/workspace/ableton-mcp/` with 7 added tools
- `project_music_library.md` — pointer to `D:\Presets, Samples and Loops`
- `project_kyle_artist_identity.md` — pointer to `~/.claude/skills/ableton/identity/`

## Prerequisites

The installer requires:

- `bash`, `jq`, `rsync`, `git` (standard on most systems — installer checks)
- `uv` for running the MCP fork — installer warns if missing but doesn't fail. Install: `curl -LsSf https://astral.sh/uv/install.sh | sh`

Platform-specific:

- **WSL2 (recommended)** — full automation, Remote Script deploys to Windows Ableton install at `C:\ProgramData\Ableton\…`
- **macOS** — most works automatically. Remote Script deploys manually to `~/Music/Ableton/User Library/Remote Scripts/AbletonMCP/`
- **Native Linux** — works for the Claude side. Ableton itself doesn't run on Linux, so the Remote Script step is N/A.

## Manual steps after install

The installer handles 95% of the setup. These you do yourself:

1. **(WSL/Windows)** In Ableton, go to **Preferences → Link, Tempo & MIDI → Control Surface** and select **AbletonMCP** in any slot. Live shows status bar message: *"AbletonMCP: Listening for commands on port 9877"*.
2. **Restart Claude Code** (`/exit` then `claude`) so the MCP server reloads with the 28-tool fork.
3. **(Optional)** Install Diva license if you want to use the 334 Diva presets in your library.
4. **(Optional)** Install Kontakt Player (free) to unlock 205-instrument Watchkeeper library + GBR Percussion of India.

## Updating the dotfiles snapshot

If you modify your music setup on the working machine and want to push it back to dotfiles:

```bash
cd ~/dotfiles/music-production

# Re-sync skills from working ~/.claude/skills/
for s in ableton ableton-lom arrangement-coach chord-pro groove-builder mastering-prep \
         midi-cleanup mixer-doctor producer-mode reference-match sidechain-setup \
         sound-designer tempo-coach vocal-chain; do
  rsync -a --delete --exclude='.git' --exclude='__pycache__' "$HOME/.claude/skills/$s/" "skills/$s/"
done

# Re-sync MCP fork
rsync -a --delete --exclude='.git' --exclude='.venv' --exclude='uv.lock' \
  "$HOME/workspace/ableton-mcp/" "mcp-fork/"

# Re-snapshot Remote Script (WSL path; adjust for Mac/Linux)
cp "/mnt/c/ProgramData/Ableton/Live125suite/Resources/MIDI Remote Scripts/AbletonMCP/__init__.py" "remote-script/"

# Re-sync memory files
cp ~/.claude/projects/-home-kyle/memory/{feedback_diva_unlicensed,project_*}.md memory/

# Re-extract config snippets
jq '{mcpServers: {ableton: .mcpServers.ableton}}' ~/.claude.json > claude-config/mcp-server.json
jq '{permissions: {allow: [.permissions.allow[] | select(. | test("ableton|music|native-instruments|ahujasid|update-config|producer-mode|mixer-doctor|midi-cleanup|reference-match|groove-builder|chord-pro|arrangement-coach|tempo-coach|sound-designer|sidechain-setup|mastering-prep|vocal-chain"))]}}' ~/.claude/settings.local.json > claude-config/permissions.json

# Commit + push
git add music-production/
git commit -m "music-production: sync latest setup"
git push
```

Future improvement: turn the above into a `sync.sh` script.

## Verifying a fresh install

After running `install.sh`:

```bash
# Skills present
ls ~/.claude/skills/ableton/identity/    # should show ARTIST-PROFILE.md etc.
ls ~/.claude/skills/ableton/genres/      # should show 22 genre docs
ls ~/.claude/skills/ableton-lom/         # should show references/ with 12 LOM docs

# MCP fork present
ls ~/workspace/ableton-mcp/MCP_Server/   # should show server.py

# Memory files present
ls ~/.claude/projects/-home-kyle/memory/ | grep -E "(diva|ableton|kyle|music)"

# Claude config has MCP server
jq '.mcpServers.ableton' ~/.claude.json
# expected output: stdio config pointing at ~/workspace/ableton-mcp/

# Permissions include mcp__ableton__*
jq '.permissions.allow | map(select(. == "mcp__ableton__*"))' ~/.claude/settings.local.json
# expected output: ["mcp__ableton__*"]

# (Ableton-side) Remote Script in place (WSL)
ls "/mnt/c/ProgramData/Ableton/Live125suite/Resources/MIDI Remote Scripts/AbletonMCP/"
# expected output: __init__.py
```

## What this does NOT include (intentionally)

- **The user's actual sample library** at `D:\Presets, Samples and Loops` (60k WAVs, 70+ packs). Too big and license-encumbered to ship via git. Restore from your own backups separately.
- **Ableton Live itself.** Buy/install separately from ableton.com.
- **VST plugins** (Diva, Serum 2, DUNE 3, FabFilter suite, Valhalla rack, etc.). Buy/install separately.
- **License keys / serials.** Never in version control.
- **`~/.claude.json` in full.** The installer merges only the MCP server entry; the rest of your Claude config (other MCP servers, projects, settings) is yours.

## Recovery scenarios

| Scenario | Recovery |
|--|--|
| Fresh machine | `git clone dotfiles && bash music-production/install.sh` |
| Lost skills only | `rsync -a music-production/skills/ ~/.claude/skills/` |
| Broken MCP fork | `rsync -a --delete music-production/mcp-fork/ ~/workspace/ableton-mcp/` |
| Lost Remote Script | `cp music-production/remote-script/__init__.py "<ableton path>/AbletonMCP/"` |
| Lost memory files | `cp music-production/memory/*.md ~/.claude/projects/-home-kyle/memory/` |
| Lost Claude config | Re-run `install.sh` — merges, doesn't overwrite |

## Sources / credits

- **MCP base:** [ahujasid/ableton-mcp](https://github.com/ahujasid/ableton-mcp) (MIT)
- **Skills bundle:** [glincker/ableton-skills](https://github.com/glincker/ableton-skills) (MIT)
- **LOM reference:** [mikecfisher/ableton-lom-skill](https://github.com/mikecfisher/ableton-lom-skill)
- **Genre docs:** 13 of 22 harvested from [bitwize-music-studio/claude-ai-music-skills](https://github.com/bitwize-music-studio/claude-ai-music-skills); 9 written for Kyle's specific style coverage

Customizations (artist identity layer, custom MCP tools, genre additions, REFERENCE-SET, SAMPLES inventory) are Kyle's own work and live in this dotfiles repo as the source of truth.
