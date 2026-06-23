# Master Chain Specification

The exact FX chain that goes on every track's master bus. **This chain IS Kyle's sound.** Same processing → consistent sonic character → listener recognition.

## Chain order (top to bottom = first to last)

```
[track audio] → Pro-Q 4 → Pro-C 2 → Saturn 2 → Pro-L 2 → [output]
```

## Device 1: FabFilter Pro-Q 4 (broad-stroke shape)

Purpose: Gentle final EQ — cut sub-mud, lift airy top, leave the rest alone.

| Band | Type | Freq | Gain | Q |
|--|--|--|--|--|
| 1 | High-pass | 25 Hz | — | 0.5 (gentle 24 dB/oct) |
| 2 | Low shelf | 80 Hz | -0.5 dB | 0.7 |
| 3 | Bell (presence) | 3.5 kHz | -0.5 dB | 1.0 |
| 4 | High shelf | 12 kHz | +0.8 dB | 0.5 |

Mode: **Linear phase** (worth the latency on master; preserves transient integrity).
Stereo width: applied to bands 4 only (slight high-end widening).

## Device 2: FabFilter Pro-C 2 (bus glue compressor)

Purpose: Subtle glue — bring elements together, NOT loudness. ~1 dB of gain reduction average.

| Parameter | Value |
|--|--|
| Style | **Vintage** (smooth, music-glue character) |
| Ratio | **2:1** |
| Threshold | Set to taste — typically -8 to -10 dB |
| Attack | **30 ms** (preserve transients) |
| Release | **100 ms** (musical breathing) |
| Knee | 6 dB (soft knee for smooth onset) |
| Lookahead | 1 ms |
| Mix | 100% (full-band, no parallel) |
| Auto gain | OFF (you control output) |
| Gain reduction target | **1–2 dB average, max 3 dB on peaks** |

If GR > 3 dB consistently, the compressor is doing too much. Either back off threshold or use Pro-L 2 for control.

## Device 3: FabFilter Saturn 2 (subtle warmth)

Purpose: Add warmth and harmonic content without obvious distortion. The "analog feel" final touch.

| Parameter | Value |
|--|--|
| Mode | **Tape (Subtle)** factory preset as starting point |
| Drive | **12%** |
| Mix | **100%** (use Drive to control intensity) |
| Tone | -0.5 (slight darkening) |
| Dynamics | 30% (preserves dynamics) |
| Feedback | OFF |
| Output | -0.3 dB (just below clipping) |

If you can clearly *hear* the saturation, it's too much. Subtle is the goal.

## Device 4: FabFilter Pro-L 2 (true-peak limiter, final stage)

Purpose: Catch peaks, set final ceiling, NOT to slam loud.

| Parameter | Value |
|--|--|
| Style | **Modern** (clean, transparent) |
| Output | **-0.3 dB TP** (true peak — leaves headroom for streaming codecs) |
| Gain | Set so program-level GR is 3–6 dB max (NOT more) |
| Lookahead | 10 ms |
| Release | **Auto** (the algorithm picks well) |
| Channel link | 100% (stereo-locked) |
| Oversampling | **4x** (clean true-peak detection) |
| DC offset removal | ON |

Loudness reading targets (use the built-in meter):
- **Streaming master:** Integrated LUFS at **-14**
- **DJ pre-master:** Integrated LUFS at **-10** (4 dB above streaming)
- **Club master:** Integrated LUFS at **-8** (if explicitly producing for club PA)

If you're hitting these LUFS targets but using more than 6 dB of GR on Pro-L 2, your earlier chain is too loud — turn down Pro-C 2's makeup or your premix.

## Why these specific choices

- **Pro-Q 4 in Linear Phase:** master bus is one of the only places where the latency cost is fine and phase coherence preservation matters.
- **Pro-C 2 Vintage style:** smoother color than Clean/Punch; sounds more like an SSL bus comp than a transparent digital one. Adds the "glue" Kyle's prog tracks want.
- **Saturn 2 at low drive:** ear's threshold for noticing distortion is around 18-20% on Tape Subtle; 12% is below that → you get the harmonic warmth without anyone consciously hearing distortion.
- **Pro-L 2 at -0.3 dBTP:** standard for streaming-codec-safe true-peak. Spotify/Apple Music convert your master to AAC/MP3, which can add ~0.7 dB of peak overshoot. -0.3 dBTP keeps you safe.

## Deployment (next-session task)

Once Claude Code is restarted with the new MCP server, execute [[master-chain-deploy.md]]. It runs:

```python
add_effect_to_track(track_type='master', uri='query:Plugins#VST3:FabFilter:Pro-Q%204')
add_effect_to_track(track_type='master', uri='query:Plugins#VST3:FabFilter:Pro-C%202')
add_effect_to_track(track_type='master', uri='query:Plugins#VST3:FabFilter:Saturn%202')
add_effect_to_track(track_type='master', uri='query:Plugins#VST3:FabFilter:Pro-L%202')
```

Then parameter-dial via `set_device_parameter` calls per the tables above.

## Saving as an Ableton rack

Once dialed in, save as an Ableton Audio Effect Rack:
1. Select all 4 master devices
2. Right-click → "Group"
3. Name the rack "Kyle Master"
4. Save to user library at `D:\Ableton Projects\Templates\Master Chains\Kyle Master.adg`

Future projects: load the rack as a one-click drop, instead of re-deploying via MCP. The MCP path is for fresh templates; the .adg is for working projects.

## When to break the chain

Almost never. The exceptions:
- **Mastering session sent to an engineer:** strip master chain entirely; let them work from your pre-master.
- **A track explicitly meant to sound un-Kyle** (collab where you want to step outside, or a totally experimental piece). Mark these explicitly: "this track does NOT use the master chain."
- **A specific creative effect** requires routing past the limiter (rare).

## When to revisit / re-dial

Every 6 months, A/B your master chain against your current taste. The chain should evolve as your ear evolves — but slowly. If you make 10 tracks with the same chain and they all sound right, don't fix what isn't broken.
