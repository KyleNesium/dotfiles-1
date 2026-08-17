# Mixing Practices — Channel-Level Best Practices

How to add a new element to a mix without breaking it. **Read this before placing ANY new content in an existing project.**

## ⚠️ Cardinal rule — new elements enter QUIET

**The single most important rule.** When you add a new track, sample, or MIDI clip to an existing mix:

1. **Set the track volume to -15 to -12 dBFS BEFORE the content plays** — in Ableton's mixer, slide volume slider down to around 0.55-0.65 (default is 0.85 = unity).
2. Listen in context. Let the new element sit BENEATH the existing mix at first.
3. **Slowly raise** until it just begins to be audible.
4. NEVER place new content at default volume in an existing mix. It will dominate everything.

> **Why this matters:** existing tracks have already been level-balanced relative to each other. Dropping a new element at unity gain is like turning up one slider to +12 dB in a finished mix — it instantly destroys the balance.

This is the rule I broke when I added the Lead Synth at default 0.85 to dipper.als. **It's the most common mistake when adding content programmatically — the AI doesn't think about gain staging.**

## Gain staging discipline

The signal flow goes: **clip → track input → devices → track output → group bus → master**.

At every stage, headroom matters:

| Stage | Target peak | Why |
|--|--|--|
| Source clip / audio file | -12 to -6 dBFS | Headroom for processing |
| Track output (post-fader) | -18 to -12 dBFS RMS | Headroom for group + master |
| Group bus output | -12 dBFS RMS | Headroom for master |
| Master pre-limiter | -6 dBFS peak | Limiter does the loudness work |
| Master output (limited) | -1.0 dBFS (true peak -0.3 dBFS for streaming) | Industry standard |

**Use Utility/Gain plugin** at the START of every track to trim signal level before processing.

## Order of operations — adding a new track

When introducing ANY new element to an existing project:

```
1. Create the track
2. Name it descriptively (not "5-Audio" or "4-Serum 2")
3. SET VOLUME TO 0.55-0.65 (-12 to -15 dBFS entry)
4. Set pan (default center, ±5-15% for stereo image)
5. Load the patch/sample
6. Listen in SOLO — is the sound right? Adjust patch.
7. Unsolo. Listen in CONTEXT. Does it fit?
8. EQ — high-pass at minimum, surgical cuts if needed
9. Compress — only if needed (most tracks don't need compression)
10. Send to FX returns (reverb, delay) — typically -15 to -20 dB
11. Automate volume/filter/sends across the arrangement
```

**Steps 6-7 are non-negotiable.** Always solo first to verify the sound, then unsolo to verify the fit. If you can't hear (AI assistance scenario), you MUST ask the user to do this step.

## Channel EQ practices

Every channel that's not a kick/sub should have a high-pass filter:

| Track type | High-pass at | Why |
|--|--|--|
| Kick | 25-35 Hz | Removes inaudible rumble, keeps headroom |
| Sub / 808 | 25-30 Hz | Same |
| Bass (main) | 40-50 Hz (let sub own below) | Avoid sub-frequency conflict |
| Snare / clap | 100-150 Hz | Frees up low-end |
| Hi-hats / shakers / cymbals | 200-300 Hz | Frees up everything below |
| Pads | 150-200 Hz | Frees up bass region |
| Leads / synths | 100-200 Hz | Same |
| Vocals | 80-100 Hz (or 150 for thin vocals) | Frees up bass |
| FX / risers / impacts | 30-100 Hz depending on role | Most don't need sub |

**Use Ableton's EQ Eight** in the high-pass filter mode (band 1, type High-pass, slope 24 or 48 dB/oct).

Surgical cuts: every track has ONE muddy frequency around 200-400 Hz that should be cut 2-4 dB. Sweep with a narrow Q boost first to find it, then cut.

## Compression rules

**Most tracks don't need compression.** Compression is overused. Apply it only when the track has dynamic issues:

| Track type | Compression? | Settings if used |
|--|--|--|
| Kick | Light (1.5:1 ratio, 1-3 dB GR) | Punch enhancement; attack 3-10 ms, release 100-200 ms |
| Snare | Medium (2-3:1, 3-5 dB GR) | Body + sustain; attack 5-15 ms, release 100-150 ms |
| Hi-hats | Usually none | Too much = pumping artifact |
| Bass | Medium (2-4:1, 3-6 dB GR) | Consistency; attack 5-10 ms, release 100 ms |
| Lead synths | Light (1.5-2:1, 1-3 dB GR) | Sustain enhancement; attack 10-30 ms, release 80-200 ms |
| Pads | Usually none | Compression robs the breathing quality |
| Vocals | Medium-heavy (3-6:1, 4-8 dB GR) | Vocals NEED compression to sit in a mix |
| Returns (reverb/delay) | Sometimes | Tames peaks of reverb tails |

**Pre-compression EQ** matters. Cut the muddy frequencies BEFORE the compressor — otherwise it triggers on mud.

## Sidechain compression — the prog/melodic techno signature

The "pumping" sound that defines modern electronic dance music.

**Setup in Ableton 12:**

```
1. Drop Live's Compressor on the BASS track (or pad/sub)
2. Click the small triangle to expand the sidechain input
3. Source = Kick track
4. Ratio: 4:1 to 6:1
5. Attack: 0.5-2 ms (instant duck)
6. Release: 100-200 ms (depends on tempo; faster = more obvious pump)
7. Threshold: adjust so 6-10 dB of GR happens on each kick hit
```

**Apply to:** bass (always), pads (often), atmospheric layers (sometimes for groove enhancement). NEVER on drums, vocals, or leads — destroys their dynamics.

**Sidechain EQ trick** (more transparent than full compression):
- Drop **Envelope Follower** on kick
- Drop **EQ Eight** on bass
- Map kick's envelope to EQ Eight's low band gain (negative — pulls down on each kick)
- Result: only the low-frequency conflict ducks, rest of the bass stays

This is what Ableton 12's improved modulation routing makes easy.

## Pan rules

Default mono / center for low-frequency content:
- Kick, sub, main bass: **dead center, mono**
- Snare/clap: center (or ±10% for variation)

Stereo content (pads, hats, percussion, FX):
- Closed hat: ±5-15%
- Open hat: ±20-30%
- Shaker: ±20-40%
- Pad: stereo wide via chorus/widener
- Lead: center or ±5-10%
- Atmospheric FX: full stereo width via stereo widener

**Polyverse Wider** (user has this) is the standard tool for stereo widening — use 20-40% on pads/atmos.

## Send levels (reverb / delay)

Standard return tracks for prog/melodic techno:

| Return | Plugin | Use for |
|--|--|--|
| A — Long Plate | ValhallaVintageVerb (plate, 6s decay, predelay 30ms) | Pads, leads, vocals |
| B — Dotted Delay | ValhallaDelay (1/4 dot, 35% feedback) | Plucks, leads, vocals |
| C — Atmos Wash | ValhallaSupermassive (Gemini, 70% mix) | Pads, atmospheric layers |

**Send level conventions:**
- Vocal lead: -3 to -6 dB on plate (heavy)
- Lead synth: -8 to -12 dB on plate, -10 dB on delay
- Pluck: -6 dB on delay, -10 dB on plate
- Pad: -6 dB on plate, -8 dB on atmos
- Bass: NO sends typically (kills sub clarity)
- Drums: usually no reverb sends (kill punch)

## Group bus practices

Group your tracks logically:

| Group | Contains | Purpose |
|--|--|--|
| **Drums** | kick, snare, clap, hats, percussion, perc loops | Single fader to control all drums |
| **Bass** | sub, main bass, reese, alt bass | Bass volume / EQ control |
| **Synths** | lead, pluck, pads, arps | Melodic content control |
| **Vocals** | lead vocal, doubles, harmonies, FX | Vocal mix processing |
| **FX** | impacts, risers, transitions, atmos | FX layer balance |

**On each group bus:**
- Subtle bus compression (Glue compressor: 2:1, 30ms attack, 100ms release, 1-2 dB GR)
- EQ if needed (subtle — broad-stroke)
- Saturation if needed (very subtle)
- Volume fader for whole-group control

**Route all groups → master bus.** Don't route individual tracks to master — always through their group.

## Master bus

See [[identity/MASTER-CHAIN.md]] for the exact Kyle master chain spec. Brief summary:

```
Master output:
  → FabFilter Pro-Q 4 (broad shape, HP at 25 Hz, slight HF lift)
  → FabFilter Pro-C 2 (bus glue: 2:1, 30ms attack, 100ms release, 1-2 dB GR)
  → FabFilter Saturn 2 (subtle tape, drive 10-15%)
  → FabFilter Pro-L 2 (limiter, -0.3 dBTP ceiling, max 4-6 dB GR)
```

**LUFS targets:**
- Streaming master: -14 LUFS integrated
- DJ pre-master: -10 LUFS
- Club master: -8 LUFS (if specifically for sound system)
- True peak ceiling: always -0.3 dBFS for streaming codec safety

## The "new element entering an existing mix" protocol

Whenever adding NEW content to an EXISTING project — this is the procedure:

```
□ 1. Identify which existing tracks play during the time range you're targeting
□ 2. Identify what frequency range / role the existing content occupies
□ 3. Determine if your new element ADDS (atmospheric layer, support) or REPLACES (lead competing for attention)
□ 4. If adding a melodic element that may compete: choose ATMOSPHERIC content instead (pad, granular vocal, texture)
□ 5. Set new track volume to -12 to -15 dBFS BEFORE clip is placed
□ 6. Add high-pass filter at appropriate frequency (per table above)
□ 7. Place the content
□ 8. Listen — does it fit, fight, or disappear?
□ 9. Adjust volume up or down (NOT default) until it sits properly
□ 10. EQ surgical if there's a frequency conflict
□ 11. Add send levels appropriate to the element type
□ 12. Listen at multiple volume levels (loud + quiet) — does it still fit?
□ 13. Save with descriptive clip name
```

**For AI / MCP-assisted production:** you MUST get the user to verify steps 6-12 by listening, because you cannot hear.

## Common mistakes (real ones, not theoretical)

1. **Dropping new content at unity gain** — what I did with dipper.als
2. **Adding a melodic lead when an atmospheric layer was needed**
3. **No high-pass on a synth track** — eats into bass region
4. **Saw-wave sub bass** — too many harmonics, fights with mid bass
5. **Heavy reverb on everything** — washes out the mix
6. **Compressing every track** — kills dynamics
7. **No sidechain on bass+pads** — bass and pads compete with kick
8. **Stereo content panned center, mono content stereo-widened** — backwards
9. **No bus routing — everything direct to master** — no group control
10. **Master limiter slamming 8+ dB** — destroys punch and dynamics

## What to do BEFORE making any edit (Claude's checklist)

Before I touch a song again:

1. **Read existing arrangement clips** to know what's playing where (`get_arrangement_clips`)
2. **Read device chain on the target track** (`get_track_info`)
3. **Read the patch/sample currently loaded** — what does it sound like?
4. **Ask the user about the role** of the change — atmospheric vs melodic vs rhythmic vs supporting
5. **Set track volume to safe entry level** if I have `set_track_volume` (post-restart MCP)
6. **Propose, don't execute** for anything melodic/harmonic
7. **If executing**: create Session clip first, NEVER directly into arrangement; user fires/auditions; only then duplicate to arrangement
8. **Ask the user to listen and confirm** before placing in arrangement

## Sources

- [Music Guy Mixing — Sidechain EQ in Ableton](https://www.musicguymixing.com/sidechain-eq-ableton/)
- [Ableton Templates — Sidechain compression setup](https://www.abletontemplates.net/abten/news/sidechain-compression-setup-in-ableton-live)
- [IO Music Academy — Advanced sidechaining techniques](https://www.iomusic.academy/blog/advanced-sidechaining-techniques)
- [Icon Collective — Sidechaining in Ableton 12](https://www.iconcollective.edu/sidechaining-in-ableton-12-a-comprehensive-guide)
- [Ableton blog — Sidechain compression uses](https://www.ableton.com/en/blog/sidechain-compression-part-2-common-and-uncommon-uses/)
- [Gearspace — Mastering melodic techno](https://gearspace.com/board/mastering-forum/1411799-mastering-melodic-techno.html)
