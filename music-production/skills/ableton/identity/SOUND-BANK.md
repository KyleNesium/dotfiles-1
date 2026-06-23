# Kyle Sound Bank — patch manifest

10 custom patches that ARE Kyle's starting sonic palette. Built once. Used everywhere. Listeners hear the same voices across your tracks → recognition.

**Naming convention:** `K-XXX [role] [character]`

## The patches (10 total)

### Bass (3 patches)

| ID | Name | Synth | Role | Sonic target |
|--|--|--|--|--|
| **K-001** | `K-001 Sub Pure` | Operator (stock) | Foundation sub — every track's lowest fundamental | Pure sine wave, slight detune, very fast attack/release. ZERO presence above 200 Hz. The "you feel it but don't hear it" bass. |
| **K-002** | `K-002 Bass Roll Dark` | Drift (stock) | Rolling 16th-note prog bass | Triangle + saw oscillators, low-pass filter with slight envelope, sidechain-friendly. Body 80-200 Hz. The Ezequiel-Arias-style rolling bass. |
| **K-003** | `K-003 Bass Pluck Modular` | Serum 2 | Plucky 8th-note bass | Sharp attack, fast decay, slight FM modulation on filter. For tech-leaning tracks. The Adriatique/Mind Against bass style. |

### Lead / Pluck (3 patches)

| ID | Name | Synth | Role | Sonic target |
|--|--|--|--|--|
| **K-004** | `K-004 Pluck Modular Bright` | Serum 2 | The signature melodic pluck | Wavetable position-modulated by LFO. Bright but with rolloff. Heavy 1/4-dotted delay + plate reverb send. The Datacode FOCUS-style Diva pluck, recreated in Serum. |
| **K-005** | `K-005 Lead Soaring` | Drift (stock) | Emotional lead for breakdowns | Saw + triangle, slow attack (200ms), long sustain. Sits in the 1-3 kHz range. The Tale Of Us "North Star" lead. |
| **K-006** | `K-006 Arp Modular` | Wavetable (stock) | Background arp for atmosphere | Wavetable position automated subtly. Quick attack, medium decay. 16th-note arp in any key. Sits behind the main melody. |

### Pads (3 patches)

| ID | Name | Synth | Role | Sonic target |
|--|--|--|--|--|
| **K-007** | `K-007 Pad Lush Long` | Analog (stock) | Sustained chord bed | Two saw oscillators, slow filter envelope, chorus on. The "warm Diva pad without Diva" — for chord beds in breakdowns. |
| **K-008** | `K-008 Pad Evolving` | Wavetable (stock) | Movement-based texture | Wavetable position modulated by slow LFO (~0.1 Hz — one cycle per 10s). Always changing, never settling. The Ben Böhmer atmospheric texture. |
| **K-009** | `K-009 Pad Air High` | Wavetable (stock) | Top-end atmospheric layer | Bright, granular-feeling, sits above 4 kHz. Sidechained to kick for breathing. The Cattaneo "air layer" sound. |

### Texture / FX (1 patch)

| ID | Name | Synth | Role | Sonic target |
|--|--|--|--|--|
| **K-010** | `K-010 Noise Riser` | Sampler (white noise) | The reverse-cymbal source for the signature move | White noise → automated low-pass filter → reverse. 1-bar length at 122 BPM = exactly 2 seconds. THE element for the [[SIGNATURE-MOVE]] sweep. |

## Build order (do over multiple sessions, not all at once)

**Session 1:** K-002 (Bass Roll Dark) + K-004 (Pluck Modular Bright)
- These are the two you'll use in literally every prog track
- High-impact starting points

**Session 2:** K-001 (Sub Pure) + K-007 (Pad Lush Long)
- Adds foundation + chord bed
- Now you can write a 4-chord progression with everything in the Kyle palette

**Session 3:** K-005 (Lead Soaring) + K-008 (Pad Evolving)
- Emotional lead + movement layer
- Tracks can now feel "complete" entirely in your own sounds

**Session 4:** K-003 (Bass Pluck Modular) + K-006 (Arp Modular) + K-009 (Pad Air High)
- Tech-leaning bass + arp + air pad
- Covers the melodic-techno lane

**Session 5:** K-010 (Noise Riser)
- The signature move source
- Quick to design, easy to deploy

## Build protocol

Each patch built using the AI-assisted sound design loop:

1. You name a reference track or feeling
2. I tweak synth parameters via `set_device_parameter` (new MCP tool — requires Claude Code restart)
3. You play notes and react ("more grit", "softer attack", "less filter")
4. I iterate
5. When right, you save as preset
6. Annotate the patch's row in this manifest with date saved + any notes

Full protocol: [[sound-bank-protocol.md]].

## File system

Saved Drift presets: `C:\Users\the-k\OneDrive\Documents\Ableton\User Library\Presets\Instruments\Drift\Kyle\`
Saved Wavetable presets: `…\Presets\Instruments\Wavetable\Kyle\`
Saved Analog presets: `…\Presets\Instruments\Analog\Kyle\`
Saved Operator presets: `…\Presets\Instruments\Operator\Kyle\`
Serum 2 patches: save inside Serum's own preset bank as folder "Kyle"

## Evolution

This list is a starting point — by track 20, you might add K-011, K-012, etc. The point is *a small core that you use everywhere*, not 200 patches you forget about.

## Usage in tracks

Every Kyle track should source at least **3 of these 10 patches** as primary sound sources. The other instruments can be from your bought packs / library, but the spine should come from your own bank.

## When NOT to use the bank

- A track explicitly meant to step outside (genre experimentation per [[ARTIST-PROFILE]] cross-genre calendar)
- A collab where the other artist's sound should dominate
- A remix where you're serving the source material

Otherwise: default to your own sounds. Bought presets are seasoning, not the meal.
