# Patch Specifications — K-001 through K-010

Detailed implementation blueprint for the Kyle Sound Bank. **Companion to [[SOUND-BANK.md]]**. Where SOUND-BANK.md says *"K-002 — like Sudbeat"*, this file says *"oscillator A: triangle, oscillator B: saw -1 octave, filter LP24 cutoff 1200 Hz, resonance 15%, envelope amount +30%, attack 1ms, decay 250ms…"*

When building a patch via [[sound-bank-protocol.md]], use the spec below as the **starting parameter set**, then iterate with the AI loop. The spec is the floor, not the ceiling.

---

## K-001 — Sub Pure (Operator)

**Role:** The fundamental — every track's lowest layer. Tonal, clean, mono, sidechain-friendly.

| Parameter | Value | Why |
|--|--|--|
| Algorithm | A (single operator chain) | Pure sine, no FM mod |
| Operator A waveform | Sine | The only operator used |
| Operator A coarse tune | -24 semitones (-2 octaves) | Drops into proper sub range |
| Operator A fine tune | 0 | No detune — clarity |
| Operator A level | 0 dB (max) | Full level |
| Filter | OFF / bypass | Sub doesn't need filtering |
| Amp Envelope Attack | 0.5 ms | Instant attack |
| Amp Envelope Decay | 100 ms | — |
| Amp Envelope Sustain | 100% | Held notes ring out |
| Amp Envelope Release | 80 ms | Short release for tight notes |
| Voicing | Mono, glide OFF | Sub is monophonic |
| Velocity → Volume | 30% | Mild dynamic response |

**Per-track usage:**
- High-pass at 25 Hz on Pro-Q (clean below the rumble zone)
- Heavily sidechained to kick (10-15 ms attack on Pro-C, fast release)
- Pan: dead center (mono)
- Volume: -8 dB at the source

**The "K-001 sound check":** play A1 (MIDI 33). Should feel like a wave passing through your chest with no audible "synth" character above 100 Hz.

---

## K-002 — Bass Roll Dark (Drift)

**Role:** Rolling 16th-note prog bass. The Ezequiel-Arias-on-Sudbeat workhorse.

| Parameter | Value | Why |
|--|--|--|
| Oscillator 1 type | Triangle | Warmth without harmonic harshness |
| Oscillator 1 octave | 0 | Reference range |
| Oscillator 2 type | Saw | Adds body |
| Oscillator 2 octave | -1 | Below Osc1 for thickness |
| Oscillator 2 level | -6 dB (lower than Osc1) | Doesn't dominate |
| Filter type | Low-pass 24 dB | Aggressive rolloff |
| Filter cutoff | 1200 Hz | Dark but with presence |
| Filter resonance | 15% | Slight peak emphasis at cutoff |
| Filter envelope amount | +30% | Cutoff opens slightly on each note |
| Filter envelope attack | 2 ms | Fast bite |
| Filter envelope decay | 200 ms | Decays back to base cutoff |
| Filter envelope sustain | 0% | Returns to base after decay |
| Amp envelope attack | 1 ms | Instant |
| Amp envelope decay | 250 ms | Short — tight rolling feel |
| Amp envelope sustain | 100% | — |
| Amp envelope release | 50 ms | Very short — prevents tail clutter |
| LFO | OFF for now | Adds movement later if needed |
| Drift (Drift's vintage character) | 20% | Slight analog drift / pitch instability |
| Built-in chorus | OFF | Cleaner sub presence |

**Per-track usage:**
- Pro-Q: HP at 60 Hz (lets K-001 own below), low shelf -1 dB at 200 Hz, slight bell +1 dB at 800 Hz for body
- Pro-C 2: heavy sidechain from kick (8:1 ratio, 5 ms attack, 100 ms release, 6-8 dB GR on each kick hit)
- Pan: center to slight right (+5%)
- Saturation: Saturn 2 at 8% drive for analog grit
- Send to Long Plate (Return A) at -25 dB for subtle space

**The "K-002 sound check":** play A1 in 16th notes. Should feel propulsive, dark, with a slight bite on each note attack. NOT clean — slightly gritty.

---

## K-003 — Bass Pluck Modular (Serum 2)

**Role:** Plucky 8th-note bass for tech-leaning tracks. The Adriatique / Mind Against style.

| Parameter | Value | Why |
|--|--|--|
| Oscillator A wavetable | "Basic Shapes" — Square morph | Sharp attack with body |
| Oscillator A unison voices | 3 | Slight stereo width |
| Oscillator A unison detune | 8% | Subtle chorus effect |
| Oscillator B | OFF | Single-osc keeps it tight |
| Sub oscillator | Sine, -1 octave, -12 dB | Body without mud |
| Filter type | Low-pass MG24 (vintage character) | Adds character |
| Filter cutoff | 800 Hz | Plucky range |
| Filter resonance | 30% | Vocal quality |
| Filter envelope amount | +60% | Big cutoff sweep on attack |
| Filter envelope attack | 1 ms | Instant |
| Filter envelope decay | 80 ms | Fast plucky decay |
| Filter envelope sustain | 0% | Returns to base |
| Amp envelope attack | 1 ms | — |
| Amp envelope decay | 150 ms | Short for pluck character |
| Amp envelope sustain | 0% | Pluck — no sustain |
| Amp envelope release | 80 ms | — |
| LFO 1 | Triangle, 1/8, → Filter cutoff +5% | Subtle movement |
| Effects rack | Phaser OFF, Reverb OFF (use sends) | Process externally |

**Per-track usage:**
- Pro-Q: HP at 80 Hz, body band +2 dB at 250 Hz
- Pro-C 2: sidechain ducking from kick (4:1 ratio, 15 ms attack, 80 ms release)
- Layer with K-001 for fundamental
- Send to dotted delay (Return B) at -18 dB for groove enhancement

**The "K-003 sound check":** play A1 8th notes. Should feel tight, modular, with each note having a clear "ping" character and clean decay.

---

## K-004 — Pluck Modular Bright (Serum 2)

**Role:** THE signature melodic pluck. Heavy delay/reverb territory. The Datacode FOCUS Diva-style pluck recreated.

| Parameter | Value | Why |
|--|--|--|
| Oscillator A wavetable | "Analog" pack — choose a bright saw/square morph | Bell-like brightness |
| Oscillator A unison voices | 5 | Wide stereo |
| Oscillator A unison detune | 12% | Detuned chorus character |
| Oscillator A wavetable position | 25% | Slightly past 0 for character |
| Oscillator A position modulation | LFO1 at depth 8% | Subtle movement |
| Oscillator B | OFF | Keep it clean |
| Sub oscillator | OFF | This is a high-register pluck |
| Filter type | Band-pass MG12 | Tonal focus, removes mud |
| Filter cutoff | 1500 Hz | Centered in pluck range |
| Filter resonance | 35% | Vocal/bell quality |
| Filter envelope amount | +40% | Cutoff opens on attack |
| Filter envelope attack | 1 ms | Instant |
| Filter envelope decay | 200 ms | Decays to base |
| Filter envelope sustain | 0% | Returns to base |
| Amp envelope attack | 1 ms | Instant pluck |
| Amp envelope decay | 250 ms | Audible decay |
| Amp envelope sustain | 0% | True pluck — no sustain |
| Amp envelope release | 200 ms | Allows note tails to ring |
| LFO 1 | Triangle, 0.5 Hz, → Wavetable position | Constant subtle morphing |
| LFO 2 | Sine, 1/8, → Filter cutoff +5% | Rhythmic micro-modulation |
| Effects rack: Chorus | ON, depth 25%, rate 0.3 Hz | Built-in width |
| Effects rack: Reverb | OFF (use sends) | External processing |

**Per-track usage:**
- Pro-Q: HP at 200 Hz (lets bass own low end), gentle high shelf +1 dB at 8 kHz
- Pro-C 2: subtle compression (4:1 ratio, 10 ms attack, 200 ms release, 1-2 dB GR)
- Heavy sends to:
  - **Dotted Delay (Return B):** -8 dB at 1/4 dotted, feedback 35%
  - **Long Plate (Return A):** -12 dB
- Polyverse Wider at 20% on the track

**The "K-004 sound check":** play a 4-note arp (A4 → C5 → E5 → A5). Should feel modular, bell-like, with the delay tails painting the space behind the notes.

---

## K-005 — Lead Soaring (Drift)

**Role:** Emotional lead for breakdowns and big melodic moments. The Tale Of Us "North Star" lead.

| Parameter | Value | Why |
|--|--|--|
| Oscillator 1 type | Saw | Bright fundamental |
| Oscillator 1 octave | 0 | — |
| Oscillator 2 type | Triangle | Adds smoothness |
| Oscillator 2 octave | -1 | Below for warmth |
| Oscillator 2 level | -4 dB | Supporting role |
| Oscillator detune | +8 cents on Osc2 | Chorus thickness |
| Filter type | Low-pass 24 dB | Smooth rolloff |
| Filter cutoff | 4000 Hz | Bright but rolled off |
| Filter resonance | 10% | Subtle character |
| Filter envelope amount | +15% | Slight opening on attack |
| Filter envelope attack | 50 ms | Slow open |
| Filter envelope decay | 1000 ms | Long decay |
| Filter envelope sustain | 70% | Holds open |
| Amp envelope attack | 200 ms | Slow swell — emotional |
| Amp envelope decay | 500 ms | — |
| Amp envelope sustain | 100% | Held notes ring out |
| Amp envelope release | 800 ms | Long tail |
| LFO 1 | Sine, 5 Hz, → Osc pitch ±5 cents (vibrato) | Vocal-like character |
| LFO 1 delay | 200 ms | Vibrato starts after attack |
| Drift character | 30% | Lots of analog drift |
| Voice mode | Polyphonic | Chords + leads |

**Per-track usage:**
- Pro-Q: gentle HP at 100 Hz, bell -1 dB at 3 kHz (de-harshness), high shelf +1 dB at 10 kHz (air)
- Pro-C 2: 4:1 ratio, 30 ms attack, 200 ms release, 2-3 dB GR
- Sends:
  - **Long Plate (Return A):** -6 dB (LOTS of reverb)
  - **Dotted Delay (Return B):** -10 dB
- Polyverse Wider at 30%

**The "K-005 sound check":** play C5 sustained for 4 beats. Should swell in slowly, develop vibrato after 200 ms, fill the stereo image, decay slowly.

---

## K-006 — Arp Modular (Wavetable)

**Role:** Background arp for atmospheric movement. Sits behind everything.

| Parameter | Value | Why |
|--|--|--|
| Oscillator 1 wavetable | "Basics" — a clean position around 30% | Modular/synthwave character |
| Oscillator 1 wavetable position | 30% | Specific timbral spot |
| Oscillator 1 position modulation | LFO at 5%, rate 0.2 Hz | Slow evolution |
| Oscillator 2 | OFF | Keep it minimal |
| Sub | OFF | Background only — no sub presence |
| Filter | Low-pass 12 dB | Gentle |
| Filter cutoff | 2500 Hz | Mid-bright |
| Filter resonance | 15% | Slight character |
| Filter envelope | OFF (no modulation needed) | Static |
| Amp envelope attack | 5 ms | Quick attack for arp clarity |
| Amp envelope decay | 150 ms | Short for arp definition |
| Amp envelope sustain | 0% | Pluck character |
| Amp envelope release | 200 ms | Slight tail |
| LFO 1 | Sine, 1/16, → Filter cutoff ±200 Hz | Subtle rhythmic motion |
| Built-in unison | 2 voices, 5 cents detune | Subtle width |
| Effects | Chorus ON at 15% | Built-in width |

**Per-track usage:**
- Pro-Q: HP at 200 Hz, low shelf -2 dB at 400 Hz (makes room for lead)
- Volume: -15 dB (very background)
- Pan: ±25% (offset from center for stereo presence)
- Send to **Dotted Delay (Return B)** at -15 dB

**The "K-006 sound check":** play a 16th-note arp pattern (A4, C5, E5, A5 looping). Should sit behind imagined lead notes without competing — feels like ambient detail.

---

## K-007 — Pad Lush Long (Analog)

**Role:** Sustained chord bed. The "warm Diva pad without Diva."

| Parameter | Value | Why |
|--|--|--|
| Oscillator 1 type | Saw | Lush harmonic content |
| Oscillator 2 type | Saw | Same wave for detune chorus |
| Oscillator 2 detune | +3 cents | Chorus effect |
| Oscillator mix | 50/50 | Equal balance |
| Sub oscillator | Sine, -1 octave, -10 dB | Body |
| Filter type | Low-pass 24 dB ladder | Vintage character |
| Filter cutoff | 2000 Hz | Warm |
| Filter resonance | 5% | Minimal |
| Filter envelope amount | +20% | Slight opening on attack |
| Filter envelope attack | 1000 ms | Slow open |
| Filter envelope decay | 2000 ms | Long decay |
| Filter envelope sustain | 50% | Holds partially open |
| Amp envelope attack | 300 ms | Slow swell |
| Amp envelope decay | 1000 ms | — |
| Amp envelope sustain | 100% | Held forever |
| Amp envelope release | 2000 ms | Long tail |
| LFO 1 | Triangle, 0.1 Hz, → Filter cutoff ±300 Hz | Slow filter sweep |
| Chorus | ON, depth 40%, rate 0.4 Hz | Built-in width |
| Voice mode | Polyphonic, 8 voices | Stacked chords |

**Per-track usage:**
- Pro-Q: HP at 80 Hz, low shelf -1 dB at 250 Hz, slight high shelf at 8 kHz
- Pro-C 2: slow ratio (2:1), 50 ms attack, 500 ms release, 2-3 dB GR
- Heavy sends:
  - **Long Plate (Return A):** -6 dB (massive space)
  - **Atmos Wash (Return C):** -12 dB (Supermassive shimmer)
- Polyverse Wider at 25%
- Pan: dead center

**The "K-007 sound check":** play A3-C4-E4 triad sustained. Should swell in slowly over 300 ms, develop chorus shimmer, fill the stereo image, hold indefinitely with slow filter movement.

---

## K-008 — Pad Evolving (Wavetable)

**Role:** Movement-based texture. Always changing, never settling.

| Parameter | Value | Why |
|--|--|--|
| Oscillator 1 wavetable | "Evolutionary" or "Texture" wavetable | Designed for morphing |
| Oscillator 1 wavetable position | 20% (starting) | LFO modulates from here |
| Oscillator 1 position modulation | LFO1 at depth 30%, rate 0.1 Hz | Slow continuous morph |
| Oscillator 2 | Same wavetable, OFFSET position +40% | Layered movement |
| Oscillator 2 position modulation | LFO2 (different rate) at depth 25% | Independent morphing |
| Sub | OFF | Texture only |
| Filter type | Band-pass 12 dB | Tonal focus |
| Filter cutoff | 3000 Hz | Centered in pad range |
| Filter resonance | 20% | Character |
| Filter modulation | LFO3 (sawtooth, 0.05 Hz) → cutoff ±500 Hz | Slow filter sweep |
| Amp envelope attack | 500 ms | Slow swell |
| Amp envelope sustain | 100% | Holds |
| Amp envelope release | 3000 ms | Very long tail |
| LFO 1 | Sine, 0.1 Hz | Position 1 morph |
| LFO 2 | Triangle, 0.15 Hz | Position 2 morph (different rate = phasing) |
| LFO 3 | Sawtooth, 0.05 Hz | Filter sweep |
| Effects: Chorus | ON at 30% | Stereo width |
| Effects: Reverb | OFF (use sends) | — |
| Voice mode | Polyphonic, 6 voices | — |

**Per-track usage:**
- Pro-Q: HP at 100 Hz, bell +1 dB at 1.5 kHz for texture presence
- Volume: -10 dB
- Pan: center (it's stereo-wide enough)
- Sends:
  - **Long Plate (Return A):** -6 dB
  - **Atmos Wash (Return C):** -3 dB (HEAVY shimmer)
- Polyverse Wider at 40%

**The "K-008 sound check":** play A3 sustained for 30 seconds. Should never sound exactly the same twice — constant subtle evolution.

---

## K-009 — Pad Air High (Wavetable)

**Role:** Top-end atmospheric layer above 4 kHz. The "Cattaneo air layer."

| Parameter | Value | Why |
|--|--|--|
| Oscillator 1 wavetable | Bright/shimmery wavetable (Air pack if available) | Top-end character |
| Oscillator 1 wavetable position | 60% | Bright zone |
| Oscillator 1 unison voices | 4 | Wide stereo |
| Oscillator 1 unison detune | 15% | Lots of detune for shimmer |
| Oscillator 2 | OFF | Cleaner |
| Sub | OFF | High-register only |
| Filter type | Low-pass 12 dB | Gentle rolloff |
| Filter cutoff | 8000 Hz | High position — keeps shimmer |
| Filter envelope amount | 0% | No envelope modulation |
| Amp envelope attack | 500 ms | Slow swell |
| Amp envelope sustain | 100% | Held |
| Amp envelope release | 2000 ms | Long tail |
| LFO 1 | Sine, 0.3 Hz, → Filter cutoff ±2000 Hz | Slow filter sweeps |
| Effects: Chorus | ON at 40% | Width |

**Per-track usage:**
- Pro-Q: **High-pass at 4 kHz** (HARD high-pass — this pad only lives above 4 kHz, doesn't compete with anything)
- Volume: -12 dB
- Pan: dead center (relies on stereo width from oscillator unison)
- Sends:
  - **Atmos Wash (Return C):** -3 dB (lots of shimmer)
  - **Long Plate (Return A):** -10 dB
- Sidechained to kick (subtle, 3 dB GR) for breathing

**The "K-009 sound check":** play A4 sustained. Should sit ABOVE everything else in the spectrum — felt as "air" rather than melody.

---

## K-010 — Noise Riser (Sampler)

**Role:** The reverse-cymbal source for [[SIGNATURE-MOVE]] "the breath."

**Source material:** White noise sample, 2 seconds long (= 1 bar at 122 BPM).

| Parameter | Value | Why |
|--|--|--|
| Sample | White noise, 2 sec, 24-bit | The raw material |
| Loop mode | OFF (one-shot only) | Each trigger plays once |
| Reverse | ON | Energy builds INTO the trigger point |
| Filter type | Low-pass 12 dB | Smooth rolloff |
| Filter cutoff | Automated: 200 Hz → 12000 Hz over the bar | The "sweep up" character |
| Filter envelope | Manual automation lane, not internal | Use clip envelopes |
| Amp envelope | Match clip length — 2 sec triangle (in then out) | Volume swell |
| Pitch | 0 (original) | Keep noise character |
| Voice mode | Mono | One swell at a time |

**Per-track usage:**
- Place ONE noise riser clip per section transition
- Position: exactly 1 bar BEFORE the section change (so the swell builds into the change)
- Volume automation: -∞ → -6 dB across the bar
- EQ: high-pass at 200 Hz (no sub interference)
- Send to **Long Plate (Return A)** at -10 dB (atmospheric tail continues after the swell)

**The "K-010 sound check":** trigger it. Should rise from inaudible to a swelling whoosh, with the highest frequencies arriving at the end (because reversed + filter sweep up).

---

## Build order (do over multiple sessions)

| Session | Build | Approx time | Cumulative coverage |
|--|--|--|--|
| 1 | K-002 + K-004 | 90 min | Bass + pluck — can write a full prog loop |
| 2 | K-001 + K-007 | 60 min | + Sub + lush pad — full chord progression possible |
| 3 | K-005 + K-008 | 90 min | + Lead + evolving pad — breakdowns possible |
| 4 | K-003 + K-006 + K-009 | 90 min | + Tech bass + arp + air — full melodic-techno palette |
| 5 | K-010 | 30 min | + Signature move source |

After 5 sessions (~6 hours total): full Kyle sound bank deployed.

## How to use this file during a build session

1. Open this file alongside Ableton
2. Pick the target patch (e.g. K-002)
3. Load the right synth (Drift) on a MIDI track
4. Call me with: *"Build K-002 from spec"*
5. I read the spec, call `get_device_parameters` to see Drift's current state, then `set_device_parameter` for each row in the table
6. You play and react. I iterate.
7. When right, save the preset with the K-XXX name
8. Update [[SOUND-BANK]] row with "Built [date]" + any deviation notes

## When the spec is wrong

These specs are starting points based on production knowledge. Some won't sound right. When that happens:

- Note what was wrong ("filter cutoff 1200 Hz was too dark — used 1600")
- Update the spec for next time
- Don't blindly follow specs over your ear

The spec is a head start, not a contract.
