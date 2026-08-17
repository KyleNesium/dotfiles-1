# Sound Bank Build Protocol

How to design one patch in a Kyle Sound Bank session. Repeat for each of the 10 patches in [[SOUND-BANK.md]].

## Prerequisites

- Claude Code restarted (new MCP server with `set_device_parameter` + `get_device_parameters` loaded)
- Ableton open, fresh empty project OR working session
- One MIDI track ready, instrument loaded (the synth being patched)
- 30-60 minutes of uninterrupted time

## The loop (per patch)

### Step 1 — Brief (2 min)
You describe in words what you want the patch to be. Templates:
- "K-002 — rolling 16th-note bass, dark and aggressive, like Ezequiel Arias on Sudbeat"
- "K-007 — lush sustained pad, warm analog feel, like the Anjunadeep school"
- "K-004 — bright modular-sounding pluck with heavy delay feel, like the Datacode FOCUS Diva presets"

Mention 1-2 reference tracks if helpful. The clearer the brief, the faster I tune.

### Step 2 — I read the synth's current state
I call `get_device_parameters(track, device_index, track_type)` to see every parameter's current value and range. This grounds the next moves in reality.

### Step 3 — Coarse pass (10 min)
I propose 5-8 parameter changes to get into the rough territory:
- Oscillator type / waveform selection
- Filter type, cutoff, resonance
- Amplitude envelope (attack, decay, sustain, release)
- Filter envelope amount + shape
- LFO routing if needed
- FX (reverb, chorus, delay) on/off + amounts

I call `set_device_parameter` once per change. You play a few notes after each, react.

### Step 4 — Reactive iteration (15-30 min)
You drive: *"more bite", "less filter", "longer release", "warmer", "more movement"*

I translate each request to a specific parameter change. We loop until the patch feels right. This is the actual sound-design work.

### Step 5 — Lock + name
Save the preset in Ableton (Drift / Wavetable / Analog have built-in preset save). Name it per the convention: `K-XXX [role] [character]`.

### Step 6 — Annotate [[SOUND-BANK]]
Open `SOUND-BANK.md`, update the row for that patch:
- Add "Built [date]"
- Note any surprise / lesson from the build
- Path to the saved preset

## Example session — building K-002 Bass Roll Dark

**You:** "Let's build K-002. It's a rolling 16th-note prog bass. Dark and driving. Reference: Ezequiel Arias on Sudbeat — that thick, sidechain-pumping bass that sits at 80-200 Hz."

**Me:** [calls `get_device_parameters` on Drift] *Drift is on default init. Current settings: Osc1=Saw, Osc2=off, Filter=lowpass24, cutoff=10000 Hz, resonance=0, amp ADSR=fast.*

*Proposing the coarse pass:*
- Osc1: Triangle (warmer than saw for sub presence)
- Osc2: Saw, -1 octave (adds body)
- Filter cutoff: 600 Hz (closes things down — dark territory)
- Filter resonance: 15% (slight peak emphasis)
- Filter envelope amount: +30% (slight movement on attack)
- Filter envelope attack: 2ms
- Filter envelope decay: 200ms
- Amp envelope attack: 1ms
- Amp envelope decay: 250ms
- Amp sustain: 100%
- Amp release: 50ms (short — for tight rolling feel)

[calls 10x `set_device_parameter`]

**You:** [plays a 16th-note A1 pattern] "Too dull. I want more presence."

**Me:** [bumps cutoff from 600 to 1200 Hz] *Done.*

**You:** "Better. But now it feels too smooth — I want a little dirt."

**Me:** [proposes adding Drift's built-in drive, sets to 20%]

**You:** "Yeah. And less of that sub octave."

**Me:** [reduces Osc2 level from 0 dB to -6 dB]

**You:** [plays it] "Yes, this is it. Save."

**You:** [hits Save in Drift, types "K-002 Bass Roll Dark", saves to user library]

**Me:** [updates SOUND-BANK.md row with "Built 2026-06-23, notes: 1200 Hz cutoff was the unlock — original 600 Hz too dark"]

Total time: ~20 minutes.

## Reference templates per patch

### For K-001 Sub Pure (Operator)
- Algorithm: Single operator (algorithm A)
- Waveform: Sine
- Coarse tune: -2 octaves (very low)
- Slight chorus for movement
- Fast attack, slight release

### For K-002 Bass Roll Dark (Drift)
- See example session above

### For K-004 Pluck Modular Bright (Serum 2)
- Wavetable: pick something with bell/glass character
- Filter: bandpass at 1.5 kHz, high resonance
- Envelope: very fast attack, fast decay (~150ms), no sustain
- Position modulation: LFO at 0.5 Hz, ±0.2
- Add chorus + reverb internally
- Heavy 1/4-dot delay on the track (Timeless 3)

### For K-007 Pad Lush Long (Analog)
- Two oscillators detuned slightly (-3 cents, +3 cents) for chorus effect
- Filter cutoff at ~2.5 kHz
- Slow attack (~300 ms)
- Long sustain, long release (1.5s)
- Chorus on (Analog's built-in)

### For K-008 Pad Evolving (Wavetable)
- Wavetable position automated by LFO at 0.1 Hz (slow movement)
- Filter cutoff at ~4 kHz
- Medium attack (~150 ms)
- Long sustain, medium release

## Anti-patterns (don't do these)

- **Don't over-design.** Once a patch is 80% there, save it and move on. The remaining 20% comes from how you use it in tracks, not from more knob-tweaking.
- **Don't make 10 patches in one session.** Burnout kills taste. Two patches per session, max.
- **Don't ignore the reference.** If you said "like Sudbeat" and the patch sounds like Tale Of Us, that's not the patch you said you wanted — adjust.
- **Don't save before naming.** Always commit to the K-XXX naming convention; unnamed presets get lost.
- **Don't redesign existing patches.** If K-002 needs to be different, design K-011 instead. Old patches stay frozen — they're already used in tracks.

## What this protocol actually buys

You end up with **10 patches that ARE Kyle's vocabulary**. Listeners hear K-002 across 5 of your tracks and the bass starts to feel *familiar*. That's brand. Bought presets can never do this — anyone can buy them.

## Cadence

Do 1 patch-building session per week for 5 weeks → all 10 patches done. Or batch in 1-2 weekend sessions. Either way, **don't make tracks with bought-only sounds while the bank is empty.** Build at least K-001 and K-002 before the first Kyle track.
