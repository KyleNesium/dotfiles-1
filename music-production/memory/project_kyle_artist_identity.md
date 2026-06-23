---
name: project-kyle-artist-identity
description: "Kyle's artist brand layer in Ableton — producer tag, signature move, sound bank manifest, master chain spec. Read these before any production work so output is consistent across sessions."
metadata: 
  node_type: memory
  type: project
  originSessionId: 1e32d402-97b1-43dd-8975-f5f014d4f407
---

The user is building an artist identity (working producer name: **Kyle**, working draft — confirm or change). The brand infrastructure lives at `~/.claude/skills/ableton/identity/` with seven documents:

- `ARTIST-PROFILE.md` — bedrock decisions (tempo defaults, keys, naming, LUFS targets, save paths, cross-genre calendar)
- `PRODUCER-TAG.md` — 1.5s audio signature design protocol (whispered "Kyle" + reverse-reverb tail)
- `SIGNATURE-MOVE.md` — "the breath" — reverse noise swell 1 bar before every section change
- `SOUND-BANK.md` — manifest of 10 custom patches (K-001 through K-010) across Drift/Serum 2/Wavetable/Analog/Operator
- `MASTER-CHAIN.md` — exact parameter spec for Pro-Q 4 → Pro-C 2 → Saturn 2 → Pro-L 2
- `sound-bank-protocol.md` — how to design each patch via `set_device_parameter` (requires new MCP)
- `master-chain-deploy.md` — one-call sequence to deploy master chain (requires new MCP)
- `MOMENTS-LIBRARY.md` — annotated reference log of "moments I love" in other tracks (seeded with 6 entries from user's DJ set)
- `INDEX.md` — routing/quick-reference

**Why:** The user wants production output that's recognizably them — same producer tag, same signature move ("the breath"), same custom sound bank, same master chain across every track. Recognition through consistency.

**How to apply:**
- Before starting any track: read [[ARTIST-PROFILE]] for tempo/key/naming/save defaults
- Before designing a sound: cross-reference [[SOUND-BANK]] — is there an existing patch that fits? If not, [[sound-bank-protocol]] to build a new one
- Before finishing a track: deploy master chain via [[master-chain-deploy]]
- When stuck: [[MOMENTS-LIBRARY]] for inspiration
- During section changes: deploy "the breath" per [[SIGNATURE-MOVE]]

The producer tag, sound bank, and master chain are NOT yet built — they're documented as next-session executables. Tag is a 30-min recording+processing exercise. Sound bank is 5 sessions × 2 patches each. Master chain is 15 min once Claude Code is restarted with the new MCP server.

**Defaults established (can be edited):**
- Producer name: Kyle
- Working tempo: 122 BPM (prog) / 124 BPM (melodic techno)
- Working keys: A/F/D/C minor (modal — Aeolian/Phrygian)
- Streaming LUFS: -14 / DJ pre-master: -10 / Club: -8 / True Peak ceiling: -0.3 dBTP
- Save path: `D:\Ableton Projects\YYYY-MM - Track Name\`
- Track naming: `Kyle — Track Name (Original Mix)`
- Color palette: deep blue #0a1a2f / off-white #f5f1ea / warm accent #d97757
- Signature move: "the breath" — reverse white-noise swell 1 bar before every section change
- Producer tag concept: whispered "Kyle" with reverse-reverb tail entry
