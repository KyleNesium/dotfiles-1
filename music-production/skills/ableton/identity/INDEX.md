# Kyle Identity Infrastructure — Index

The artist brand layer for Kyle. Everything that makes a track recognizably Kyle.

## Bedrock documents (read these first)

- **[ARTIST-PROFILE.md](ARTIST-PROFILE.md)** — the constitution. Producer name, working tempo/keys, recognition stack, production conventions, visual identity, cross-genre calendar, burnout-resistance ritual.

## The recognition stack (4 layers)

1. **[PRODUCER-TAG.md](PRODUCER-TAG.md)** — 1.5s audio signature at head of every track. Design protocol included.
2. **Sonic Tattoo** — covered in ARTIST-PROFILE under "Layer 2". Background texture that recurs.
3. **[SIGNATURE-MOVE.md](SIGNATURE-MOVE.md)** — the recurring production trick ("the breath" — reverse noise swell 1 bar before each section change).
4. **[SOUND-BANK.md](SOUND-BANK.md)** — 10 custom patches that ARE Kyle's vocabulary. Manifest + build order.

## Active protocols (next-session executables)

- **[sound-bank-protocol.md](sound-bank-protocol.md)** — how to design each patch using the new MCP `set_device_parameter` tool.
- **[master-chain-deploy.md](master-chain-deploy.md)** — drops the Pro-Q → Pro-C → Saturn → Pro-L master chain on the current session.
- **[MASTER-CHAIN.md](MASTER-CHAIN.md)** — exact parameter spec for every device in the master chain.
- **[PATCH-SPECS.md](PATCH-SPECS.md)** — full oscillator/filter/envelope/modulation spec for every K-XXX patch. Build-session starter values.
- **[PROJECT-FOLDER.md](PROJECT-FOLDER.md)** — standard structure of every Kyle project folder + notes.md / metadata.md / references.md templates.
- **[FIRST-TRACK-RUNBOOK.md](FIRST-TRACK-RUNBOOK.md)** — exact phase-by-phase sequence from "sitting down to make a track" to "rendered master in folder."

## Creative engines (build over time)

- **[MOMENTS-LIBRARY.md](MOMENTS-LIBRARY.md)** — annotated reference log of moments-I-love in other tracks. Seeded with 6 entries from user's set; grow weekly.

## Quick reference — what to do when

| Situation | Reach for |
|--|--|
| Starting a new project | [ARTIST-PROFILE](ARTIST-PROFILE.md) (read tempo/keys/conventions) |
| Need to design a new patch | [SOUND-BANK](SOUND-BANK.md) + [sound-bank-protocol](sound-bank-protocol.md) |
| About to finish a track | [MASTER-CHAIN](MASTER-CHAIN.md) + [master-chain-deploy](master-chain-deploy.md) |
| Track is stuck mid-build | [MOMENTS-LIBRARY](MOMENTS-LIBRARY.md) |
| Section change coming up | [SIGNATURE-MOVE](SIGNATURE-MOVE.md) (deploy "the breath") |
| Ready to do the tag | [PRODUCER-TAG](PRODUCER-TAG.md) (recording + processing protocol) |
| Naming a track for release | [ARTIST-PROFILE](ARTIST-PROFILE.md) → "Track naming for release" |
| Saving a project | [ARTIST-PROFILE](ARTIST-PROFILE.md) → "Save path convention" |

## Where Kyle's identity lives in the file system

```
~/.claude/skills/ableton/
├── CLAUDE.md                  ← main co-producer context (loads automatically)
├── REFERENCE-SET.md           ← user's DJ set DNA + subgenre taxonomy
├── SAMPLES.md                 ← bought sample library inventory
├── MCP-CAPABILITIES.md        ← MCP tool reference + gotchas
├── genres/                    ← 22 genre reference docs
├── identity/                  ← THIS DIRECTORY — Kyle's artist brand layer
└── skills/                    ← (mirror of glincker skills)
```

## When this infrastructure feels overwrought

If you're 6 tracks in and any of this feels constraining rather than enabling, edit it. The point is *recognition through consistency*, not rigidity. A signature move that doesn't fit a specific track → skip it for that track. A patch that you've outgrown → replace it. The infrastructure serves the music, not the other way around.

## What's missing (do later)

These are NOT yet in identity/ but might be worth adding:

- **collab-prep.md** — when collaborating, how to package stems + project for the other artist
- **release-checklist.md** — pre-release pre-flight (artwork ready, master rendered at all LUFS targets, metadata, ISRC code, distributor staged)
- **brand-bio.md** — short/long artist bios for press, label submissions, social media
- **field-recording-protocol.md** — how to record + process environmental sounds for the personal sample collection

Each of these can be added in a single short session when the need arises.
