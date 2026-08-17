# Sound Design — Serum 2, Drift, Wavetable, Analog

Practical synthesis reference for designing patches by role. The goal is to know what knobs to turn before opening the synth, not improvise blind.

> Companion to [[identity/PATCH-SPECS.md]] (Kyle's specific patches) and [[identity/SOUND-BANK.md]] (the manifest).

## Universal rules (apply to any synth)

### Rule of layering
- **A "fat" sound is rarely one oscillator.** Two oscillators detuned slightly creates the body. Three with subtle pitch offsets adds movement.
- **Sub + mid + air = full spectrum.** Don't try to make one patch cover 30 Hz to 18 kHz — that's a job for 2-3 stacked patches.

### Rule of envelope
- **Attack defines feel:** 0-5 ms = punchy/plucky, 50-150 ms = legato, 300-800 ms = slow swell, 1000+ ms = pad
- **Release defines mood:** short release = staccato/percussive, long release = "soaring" emotional content
- **Filter envelope adds movement.** A static filter sounds dead. Even 5% filter envelope amount makes a patch breathe.

### Rule of modulation
- **Static patches are amateur.** Professional sounds have at least 2-3 parameters being modulated subtly.
- Sources: LFOs, envelopes, sample-and-hold, velocity, keyboard tracking, macros
- Targets: filter cutoff, pitch, oscillator level, wavetable position, FX wet/dry, panning
- **Rates matter:** sub-audio LFOs (0.1-5 Hz) for slow movement, audio-rate (50+ Hz) for FM-style modulation

### Rule of imperfection
- **Detune oscillators by 3-12 cents** to thicken
- **Add slight pitch drift** (Drift's "Drift" knob, Serum's "Voice"/"Vibrato")
- **Use random sample-and-hold LFO** for subtle "alive" feel — depth 5-15%, rate 0.1-2 Hz
- Perfect tuning = sterile

## Serum 2 — what's new in v2

Serum 2 added significant capabilities over v1:
- **Spectral resynthesis** — drag in any audio, Serum analyzes spectral content, creates wavetable
- **Granular synthesis mode** — up to 256 simultaneous grains for organic textures
- **Multi-sample mode** — sample-based synthesis on top of wavetable
- **New FX rack** — additional FX slots, better routing
- **Modulation matrix improvements** — easier macro routing

Sources: [Splice Serum 2 features](https://splice.com/blog/serum-2-advanced-features/), [Monosounds production blog](https://monosounds.studio/best-xfer-serum-2-presets-for-electronic-music-producers-ultimate-guide/)

## Patch design by role

### LEAD — designed to cut through a busy mix

**Goal:** clear, present, melodic. Owns the 1-4 kHz range.

**Serum 2 starting point:**
1. **Init patch first** — never start from a preset (loses character to the source pack)
2. **Oscillator A:** Saw wavetable, **unison 5 voices**, **detune 12-15%** (wide chorus effect)
3. **Oscillator B:** Same wavetable, **-12 semitones** (sub octave), level -6 dB
4. **Filter:** Low-pass LP24 MG (vintage), cutoff 4-6 kHz, resonance 10-15%
5. **Filter envelope:** Amount +15-25%, attack 1 ms, decay 200-500 ms, sustain 50%
6. **Amp envelope:** Attack 5-30 ms (depends on feel), decay 200 ms, sustain 80%, release 500-800 ms
7. **LFO 1:** Sine, 4-6 Hz, route to oscillator pitch (vibrato), depth 5-8 cents, with **delay 200 ms** so vibrato starts after the attack
8. **Effects rack:** Chorus ON (15-25%), Hyper/Saturation light, Reverb light or use external sends

**Why this works:** unison + detune = wide stereo; LP24 = warmth without harshness; filter envelope = movement; delayed vibrato = vocal-like expression.

**Common mistakes:**
- Cutoff too high (over 8 kHz) = harsh/screechy
- No filter envelope = lifeless static tone
- Too much unison detune (20+%) = chorus mush, loses pitch clarity

### BASS — designed to sit under everything

**Goal:** clean low-end (60-250 Hz fundamental + harmonics), tight envelope, sidechain-ready.

**Serum 2 starting point:**
1. **Init patch**
2. **Oscillator A:** Triangle wavetable (NOT saw — saw has too many harmonics, gets muddy with bass)
3. **Sub oscillator:** Sine, -12 semitones, level **strong** (50-60% mix)
4. **Filter:** Low-pass MG24, cutoff 800-1200 Hz, resonance 10%
5. **Filter envelope:** Amount +30%, attack 1 ms, decay 150 ms, sustain 30%
6. **Amp envelope:** Attack 1 ms, decay 200 ms, sustain 80%, release 50-100 ms (short for tight)
7. **NO chorus, NO reverb internally** — bass needs to be mono-friendly and tight
8. **Mono mode:** ON (bass should be monophonic, no chord polyphony)
9. **Voice glide:** 30-50 ms (slight legato slide between notes)

**Filter movement variant (for "rolling" prog house bass):**
- Filter envelope amount: +60% (big cutoff sweep on each note attack)
- Amp decay: 100 ms (very short — gives the "pluck" feel)
- Amp sustain: 0% (true pluck, no held tone)

**Common mistakes:**
- Wide stereo on bass (chorus, unison) = mono-fold mud, weak sub
- Saw wave = too many harmonics, fights with other elements
- Long release on bass = bleed into next note, mud

### PAD — designed to fill space without competing

**Goal:** sustained harmonic bed. Owns 200 Hz - 4 kHz range, sits behind leads/vocals.

**Serum 2 starting point:**
1. **Oscillator A:** Saw or pad-specific wavetable, **unison 4-6 voices**, **detune 10-15%**
2. **Oscillator B:** Same, +12 semitones (octave up for shimmer), level -8 dB
3. **Filter:** Low-pass LP12 (gentler than LP24), cutoff 2-3 kHz, resonance 5%
4. **Filter LFO:** Sine, 0.1-0.2 Hz (very slow), depth 10-20% (slow filter sweep)
5. **Amp envelope:** Attack **300-500 ms** (slow swell), decay 1000 ms, sustain 100%, release **1500-3000 ms** (long tail)
6. **Built-in chorus:** ON (heavy — 30-40%) for width
7. **Built-in reverb:** OFF — use sends externally for control

**Polyphony:** 6-8 voices for chord voicings

**Common mistakes:**
- Attack too fast = pad sounds like a stab, not a sustained bed
- Cutoff too bright = fights with leads
- Not enough movement (no LFO on filter) = static, boring

### PLUCK — designed for short rhythmic melodic content

**Goal:** short attack, fast decay, definitive note end. Used for arps, stabs, rhythmic melodic patterns.

**Serum 2 starting point:**
1. **Oscillator A:** Bright wavetable (square morph, bell, etc.), unison 3 voices, detune 8%
2. **Filter:** Band-pass BP12 (tonal focus, removes mud), cutoff 1.5-2 kHz, resonance 25-35%
3. **Filter envelope:** Amount +40% (cutoff opens dramatically on attack), attack 1 ms, decay 80 ms, sustain 0%
4. **Amp envelope:** Attack 1 ms, decay 150-300 ms, sustain 0%, release 200 ms
5. **Important:** Sustain at 0% — this is what makes it a "pluck" vs a "lead"
6. **Send heavily to delay (1/4 dotted) and reverb** externally — the delay tails are the character

**Common mistakes:**
- Sustain > 0 = it's a lead, not a pluck
- No filter movement = sounds dead
- Not enough delay/reverb send = sounds dry and lonely

### ARP — background rhythmic movement

**Goal:** subtle continuous 16th-note background pattern. Behind everything.

**Same as pluck above, but:**
- Lower volume (-15 dB)
- Slightly darker filter (BP at 1.2 kHz)
- Less unison detune (5%)
- Pan slightly off-center (±15-25%)

## Randomization techniques

The user asked about this specifically — randomness creates "alive" patches that don't sound static.

### In Serum 2

1. **Sample-and-hold LFO** — generates random stepped values
   - Set LFO shape to **S&H** (sample-and-hold), rate 1-4 Hz
   - Route to: filter cutoff (depth 5-15%), oscillator pitch (depth 2-5 cents), wavetable position (depth 3-8%)
   - Result: subtle randomized "wobble" without losing pitch clarity

2. **LFO Drift/Smooth setting** — Serum 2's LFOs have a "Smooth" parameter
   - Higher smooth on a S&H LFO = filtered randomness, less jagged
   - Sweet spot: 30-50% smooth

3. **Macro randomization (Serum's dice button)** — at top of patch
   - Click dice to randomize unlocked parameters
   - **Lock the parameters you've dialed in** (right-click → Lock) before rolling
   - Useful for: discovering new patches based on existing skeleton

4. **Velocity randomization**
   - Set Velocity → Filter Cutoff at depth 20-40%
   - Result: each note plays with slightly different brightness based on velocity variance
   - Combined with humanized MIDI velocity = naturally varied performance

### In Ableton's Drift

- **Voice Drift** parameter — adds slight pitch instability to mimic vintage analog
- Set to 20-30% for vintage warmth, 50%+ for obvious wobble

### General modulation routing for "alive" patches

A pro patch typically has:
- LFO 1 (sub-audio sine, 0.1 Hz) → Filter cutoff (slow tonal evolution)
- LFO 2 (S&H, 2 Hz, 50% smooth) → Oscillator pitch ±3 cents (subtle drift)
- Velocity → Filter envelope amount (dynamic response)
- Random envelope on amp velocity = humanization

3 modulations is the floor for a "professional" patch.

## Effects within Serum 2's FX rack

Serum 2 has a built-in FX rack. Order matters:

**Standard chain for leads/pads:**
1. **Distortion** — light for warmth, heavy for character (low drive 5-15%)
2. **Compressor** — internal patch compression (1.5:1 ratio, gentle)
3. **Chorus** — for width (20-30% depth)
4. **Delay** — light tap, never heavy (better to use external send)
5. **Reverb** — same, light or off (use sends)

**Order matters:** distortion BEFORE chorus = warmer; chorus BEFORE distortion = wider but harsher.

## Per-genre patch defaults

### Melodic techno (Kyle's primary lane)
- **Lead:** bright wavetable, unison 5, detune 12%, BP filter 1.5-2 kHz, heavy delay+reverb sends, slow filter LFO
- **Bass:** triangle + sub sine, mono, LP24 ~800 Hz, sidechained, no chorus
- **Pad:** layered saws, slow attack 400ms, LP12 filter, slow LFO modulation

### Progressive house
- **Bass:** rolling 16ths, fast filter envelope, slight overdrive
- **Pluck:** analog-style, BP filter, heavy 1/4 dotted delay
- **Pad:** Diva-class warmth (use Drift as substitute), chorus, slow filter sweep

### Deep house
- **Bass:** rounder, softer attack (10-20 ms), more sub presence
- **Lead:** softer cutoff (1-2 kHz LP), less aggressive
- **Pad:** Wurly/Rhodes textures via wavetable, jazzy chord stacks

### Tech house
- **Bass:** plucky, mono, BP filter, very tight envelope
- **Lead:** chopped vocal stabs or simple Serum stabs, BP filter
- **No pad** typically — tech house lives on the drums + bass groove

## Sound design workflow (the actual order of operations)

When designing a patch from scratch:

1. **Decide the role first** — lead/bass/pad/pluck/arp/texture
2. **Decide the genre** — affects tone choices (per genre table above)
3. **Open Init patch** — never start from a preset
4. **Set oscillator(s)** — wavetable choice + unison + detune
5. **Set filter** — type + cutoff + resonance
6. **Set amp envelope** — attack/decay/sustain/release per role
7. **Set filter envelope** — usually positive amount, fast attack, role-dependent decay
8. **Add modulation (LFOs)** — at least 2 routings for "alive" feel
9. **Add internal FX sparingly** — chorus + light reverb usually enough
10. **Play notes, evaluate, adjust** — listen in context, not isolated
11. **Save preset** with descriptive name (Kyle's convention: `K-XXX [role] [character]`)

## Layering for richness

Single patches rarely sound "finished." Layer 2-3 patches for richness:

**Lead stack:**
- Main lead (your designed patch)
- Sub octave (different patch, just the fundamental)
- Air layer (high-pass wavetable above 6 kHz, very quiet — adds sparkle)

**Bass stack:**
- Sub (pure sine, -1 octave, mono)
- Mid bass (your designed bass patch, with character)
- Optional: tonal layer (saw stab for energy)

**Pad stack:**
- Warm low pad (saw layers, LP12, slow attack)
- Bright air pad (high-passed, granular or shimmery, very quiet)
- Optional: vocal pad (chopped vocal sample through reverb)

## Anti-patterns

- ❌ Starting from someone else's preset (you sound like them)
- ❌ One oscillator, no detune (thin)
- ❌ No filter envelope (lifeless)
- ❌ Modulating nothing (static)
- ❌ Heavy reverb internal to the patch (loses control)
- ❌ Polyphonic bass (mud)
- ❌ Saw wave on sub bass (too many harmonics)
- ❌ Long attack on a pluck (it's a lead now)
- ❌ Wide chorus on bass (mono-fold mud, weak sub)
- ❌ Same wavetable position throughout (boring, no evolution)

## Sources for further reading

When learning new techniques:
- **Splice blog** — solid tutorials, good for current trends
- **ADSR Sounds** — deep technical content
- **Tunecraft Sounds** — genre-specific (melodic techno is their lane)
- **Production Music Live (PML)** — your sample-pack vendor, also has YouTube tutorials
- **Reverb Machine** — synth design philosophy

Sources for this doc:
- [Splice — Serum 2 advanced features](https://splice.com/blog/serum-2-advanced-features/)
- [Monosounds — Serum 2 sound design guide](https://monosounds.studio/best-xfer-serum-2-presets-for-electronic-music-producers-ultimate-guide/)
- [ADSR — Organic wavetable design](https://www.adsrsounds.com/serum-tutorials/sound-design-build-custom-organic-wavetables-in-serum/)
- [HitProducerStash — Serum 2 spectral resynthesis 2026](https://www.hitproducerstash.com/serum-2-spectral-resynthesis-guide)
- [NoiseHarmony — 17 advanced Serum 2 tips](https://www.noiseharmony.com/post/17-advanced-tips-for-serum-2)
- [Tunecraft-sounds — Serum 2 melodic techno lead](https://www.tunecraft-sounds.com/serum-2-melodic-techno-lead-sound/)
