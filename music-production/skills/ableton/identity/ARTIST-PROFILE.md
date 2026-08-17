# Artist Profile — Kyle

The bedrock document defining "what makes a track recognizably Kyle". Every decision in production should reference back to this. Edit when something needs to evolve, but treat it as the source of truth.

## Producer identity

| Field | Decision | Why |
|--|--|--|
| **Producer name** | **Kyle** *(working draft — confirm or change)* | Default from home directory. Easy to switch to anything you prefer — "kyless", "K.S.", a one-word alias, etc. |
| **Pronouns / context** | He/him; based in South Africa (Cape Town inferred from `ringier.co.za`) | Affects genre choices (afro-house adjacency natural), local scene context |
| **Primary lane** | Progressive house / melodic techno (Sudbeat–Anjunadeep–Afterlife axis) | From [[REFERENCE-SET]] DJ set DNA — Ezequiel Arias × 5, Rauschhaus × 3, etc. |
| **Working tempo** | **122 BPM** (prog) / **124 BPM** (melodic techno) | Locked defaults for new sessions |
| **Working keys** | A minor, F minor, D minor, C minor (modal — Aeolian / Phrygian) | Matches genre conventions + emotional darkness |

## The recognition stack (4 layers, top to bottom = most to least overt)

These are the things that, *cumulatively*, make a Kyle track sound like a Kyle track.

### Layer 1 — Producer Tag (1.5s audio signature)

**Status:** Not yet recorded. Protocol: [[producer-tag-protocol.md]].

**Concept (proposed):** A whispered "Kyle" sample, processed through:
- Slight pitch-down (-2 semitones to make it lower/more atmospheric)
- Reverse-reverb tail (so the tail comes BEFORE the word, swelling into it)
- Slight Saturn 2 saturation (warmth)
- Wide stereo (Polyverse Wider 30%)

**Placement convention:**
- At the very start of every track (first 1.5 sec before the kick enters)
- Sometimes also in the breakdown for callback effect

**Why this approach:** A whispered tag is more "atmospheric" than a shouted DJ-tag (fits the prog/melodic-techno aesthetic — would feel wrong in those genres to have "KYLE!" shouted). Most prog/melodic-techno producers don't have tags, so even a subtle one stands out.

**Alternative concepts to consider:**
- Synth motif (a 4-note sequence on Diva/Drift, ~1.5s) — less personal but more melodically distinctive
- Field-recorded sound (something from your environment, processed) — most unique but harder to deploy
- Vocal phrase, not your name — a word that means something ("rise", "drift", "ember", an isiZulu word)

### Layer 2 — Sonic Tattoo (background texture, always present)

**Status:** Not yet designed.

**Concept (proposed):** A 4-bar atmospheric layer that lives on a muted-by-default track in every project. Bring in subtle in breakdowns + intros. Components:
- A field-recorded ambience (e.g. wind, ocean, room tone from a meaningful place) — sample once, use forever
- Pitched + processed to fit the track's key
- Sits at -25 dB, EQ'd to occupy only frequencies above 8 kHz and below 100 Hz (out of the way of everything else)

**Why:** Listener never consciously notices it but the *sonic world* feels consistent. Burial uses vinyl crackle for this. Bonobo uses a specific shaker swing. Boards of Canada use tape hiss.

### Layer 3 — Signature Move (production trick that recurs)

**Status:** Not yet committed. See [[SIGNATURE-MOVE.md]] for full options.

**Top candidate (proposed):** A reverse cymbal swell exactly **1 bar before every section change** (drop, breakdown, build). Specifically:
- Source: white-noise riser through automated low-pass filter
- Length: exactly 1 bar (2 seconds at 122 BPM)
- Reversed so the energy builds INTO the section change
- Routed to long reverb send (Valhalla VintageVerb plate, 6s) for atmospheric continuation
- Volume automated from -inf → -6 dB across the bar

**Why:** Universal applicability (works in every track), subtle but recognizable, easy to deploy consistently, fits the prog/melodic-techno aesthetic.

### Layer 4 — Sound Bank (custom patches as your sonic vocabulary)

**Status:** Not yet built. Manifest: [[SOUND-BANK.md]]. Protocol: [[sound-bank-protocol.md]].

**Concept:** 10 custom patches across Drift, Serum 2, Wavetable, and Operator that ARE your starting palette. Built once, used forever. Listeners hear the same sonic voices across your tracks → recognition.

Naming convention: `K-XXX [role] [character]` — e.g. `K-001 Bass Roll Dark`, `K-002 Pluck Modular Bright`.

## Production conventions (locked)

### Master chain (every track, no exceptions)

Specification: [[MASTER-CHAIN.md]]. Deploy via [[master-chain-deploy.md]] (one-call setup using the new `add_effect_to_track(track_type='master')` MCP tool — available after Claude Code restart).

Chain order: **Pro-Q 4 → Pro-C 2 → Saturn 2 → Pro-L 2**. Exact params in MASTER-CHAIN.md. This chain IS part of your sound.

### Track structure default

- 6-8 minutes (DJ-friendly extended)
- 64-bar intro (drums + bass only)
- First melodic element drops at bar 65
- Breakdown at 3:30
- Final drop at 5:00
- 32-bar outro

### LUFS targets

- **Streaming master:** -14 LUFS integrated
- **DJ-friendly pre-master:** -10 LUFS integrated
- **Club master (if you want):** -8 LUFS integrated
- **True Peak ceiling:** -0.3 dBTP always

### Save path convention

`D:\Ableton Projects\YYYY-MM - Track Name\`

Examples:
- `D:\Ableton Projects\2026-06 - First Steps\`
- `D:\Ableton Projects\2026-07 - Ember\`

YYYY-MM prefix means a year from now you can find tracks chronologically without exposed-edit-date metadata.

### Track naming for release

`Kyle — Track Name (Original Mix)` for own releases.
`Kyle — Track Name (Original Mix) [Label]` once signed to a label.
`Artist — Track Name (Kyle Remix)` for remix work.

## Visual identity (proposed)

| Element | Choice |
|--|--|
| **Color palette** | Deep blue (#0a1a2f) primary · Off-white (#f5f1ea) text · Single warm accent (#d97757 — burnt orange) |
| **Typography** | One sans-serif workhorse (Inter or Helvetica Now) |
| **Cover art aesthetic** | Minimal. Photographic, not illustrative. Long-exposure light / desert / ocean / night sky vibes. Negative space matters more than imagery. |
| **Social-feed tone** | Quiet, atmospheric. Less "look at me", more "feel this". |

These are starting points — easily changed. The point is *consistency* across releases.

## Cross-genre experimentation calendar (sustaining growth)

To prevent stagnation in the prog/melodic-techno comfort zone, schedule one off-lane track every month.

| Month | Target genre | Why |
|--|--|--|
| Month 1 (current) | Progressive house | Your spine — establish baseline |
| Month 2 | Melodic techno | Second spine — go darker |
| Month 3 | Afro-house | Built-in scene advantage (SA) |
| Month 4 | Organic house | Slow it down, lean acoustic |
| Month 5 | Desert tech | Middle Eastern fusion, low-risk experimental |
| Month 6 | Indie dance | Vocal-led, analog-warm crossover |
| Month 7 | Back to prog with everything you've learned | Synthesis |

## Burnout-resistance / WIP-rescue ritual

Every 4 weeks, open ONE old project and either:
1. Finish it (commit a release date)
2. Mine it for an idea (extract the one usable element, archive the rest)
3. Formally delete it (write a one-line "RIP" note in your project ledger)

This prevents the standard producer-graveyard problem where 50 WIPs accumulate, none get finished, and momentum dies.

## How to use this file

- Read it before starting any new project.
- Reference specific sections when making decisions ("am I about to break the master chain convention?").
- Update it when something becomes obviously wrong, but don't churn it weekly — bedrock should be slow-moving.
- The implementation files ([[SOUND-BANK]], [[MASTER-CHAIN]], etc.) are the *active* working documents. This is the constitution.
