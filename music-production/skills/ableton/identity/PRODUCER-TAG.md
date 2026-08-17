# Producer Tag — Protocol for Design + Deployment

A 1.5-second audio signature that lives at the head of every Kyle release. Once made, never re-recorded — it becomes The Tag.

## The committed concept

**Whispered "Kyle" → atmospheric processing → reverse-reverb tail entry.**

Tonal direction: low, breathy, slightly mysterious. NOT shouted, NOT bright. Should feel like the track is whispering to you before the music starts.

## Design protocol (Session 1 — 30 minutes)

This is the next-session task. Both the recording and processing happen in Ableton.

### Step 1 — Record the source (5 min)

In Ableton:
1. Set an audio track to record-arm
2. Use the laptop mic OR plug in your USB mic if you have one
3. Record yourself whispering "Kyle" — multiple takes:
   - Take 1: normal whisper
   - Take 2: slower, drawn out ("Kyyyyle")
   - Take 3: lower in pitch, more chest voice
   - Take 4: with a slight breathy sigh after
   - Take 5: held longer (vowel sustain "Kyyyyyyle")
5. Pick the take that feels most "you" — usually you'll know within 2 listens

### Step 2 — Clean it up (5 min)

On the recorded clip:
- Trim silence at start/end
- Normalize to -1 dB
- Add Live's Utility (or FabFilter Pro-G) to gate any background noise
- If breath / mouth noise is distracting, use Pro-Q 4 with a steep low-pass at 8 kHz to dampen

### Step 3 — Process it into THE TAG (15 min)

The processing chain on the tag audio:

1. **Pitch shift:** -2 semitones (lowers it slightly, adds gravity)
2. **Reverse-reverb tail technique:**
   - Duplicate the dry clip
   - On the duplicate, apply heavy reverb (Valhalla VintageVerb, 8s plate, predelay 0)
   - Render the wet reverb
   - Reverse the rendered audio
   - Place the reversed reverb tail BEFORE the dry whisper (so it swells INTO the word)
3. **Saturation:** Saturn 2 at low drive (~8%), Tape mode — adds analog warmth
4. **Stereo widening:** Polyverse Wider at ~30% — opens up the stereo image
5. **EQ shaping:** Pro-Q 4
   - High-pass at 80 Hz (no sub-content)
   - Low shelf at 200 Hz: -2 dB (less mud)
   - High shelf at 8 kHz: +3 dB (presence/air)
   - Bell at 4 kHz: +1 dB (intelligibility — listener should be able to *just* make out "Kyle")
6. **Compression:** Pro-C 2 lightly — 2:1 ratio, slow attack, fast release. Just to even out level.
7. **Final length:** ~1.5 seconds total (reverse tail + whisper combined)

### Step 4 — Render + Save (5 min)

- Export the tag as a 24-bit WAV
- Save to: `D:\Ableton Projects\Templates\Kyle Tag\Kyle Tag v1.wav`
- Also save the original Ableton project file (so you can re-render with different processing later if needed)
- Drop a copy into the Kyle template's "VOCAL / FX" track so it's pre-loaded

## Deployment rules

### Where it goes

- **Every Kyle track:** at the very start of the master output, 1.5s before the music begins (often at -8 to -10 dB so it's not abrasive)
- **Sometimes:** in the breakdown for callback effect (much quieter, like a memory)
- **DJ pre-master version:** include the tag — DJs will hear it in cue
- **Final club master:** omit (DJs hate tags in the live mix). But keep the tag for the streaming-released master version.

### Tag-friendly placement on the timeline

```
[0:00] - [0:01.5]    KYLE TAG (-8 dB, atmospheric entry)
[0:01.5] - [0:30]    Intro kick + sub (drums building)
[0:30+]              Track proper
```

The tag doesn't compete with the music — it precedes it.

## Alternatives if "Kyle" doesn't feel right

Considered options:

| Concept | Pros | Cons | Pick if |
|--|--|--|--|
| Whispered "Kyle" (the chosen) | Personal, atmospheric, simple | Has to be re-recorded if you ever change names | Your name will be your producer name long-term |
| Word that means something ("rise", "drift", "ember", an isiZulu word) | More poetic, less ego-y | Less directly attributable | You want subtlety > recognition |
| A short synth motif (4 notes on Diva when licensed) | Melodically distinctive | Less "you", more "your style" | You want it to BE music, not a vocal |
| A processed field recording (door, breath, environmental) | Unique to your environment | Harder to associate with your name | You want truly one-of-one |

If "Kyle" doesn't sit right after recording, pick one of these alternatives. Don't agonize — the first decent version is fine. The tag's job is to recur, not to be perfect.

## Evolution

After 10 tracks with v1, evaluate. You might:
- Re-record with better mic + better technique (v2)
- Add a second tag for darker tracks (v1 = main, v1-dark = darker variant)
- Refine the processing chain

But: don't re-make the tag in the first 10 tracks. Consistency builds recognition.

## Why this matters

The tag is the *cheapest* recognition asset to make and the *highest* recognition asset to own. 30 minutes of work gives you something that's on every track for the rest of your career. Compare to spending years dialing in a signature mix sound — equivalent recognition value, vastly more work.

## Sample reference points (other artists' tags)

For inspiration, not imitation:
- **Skrillex:** broken glass + "Skrillex" (chopped vocal)
- **Diplo:** "Diplo, Diplo, Diplo" pitched/stuttered
- **DJ Khaled:** "Another one"
- **Metro Boomin:** "If young Metro don't trust you" (Future's voice)
- **Tame Impala:** *no tag* — opted out entirely (also valid)
- **Most prog producers:** *no tag* — which is exactly why having one will stand out
