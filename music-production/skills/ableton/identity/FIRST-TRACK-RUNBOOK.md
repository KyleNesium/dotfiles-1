# First Track Runbook

Exact sequence from "I'm going to make a track today" to "rendered master in folder." Follow as a checklist; resists the temptation to skip steps.

This runbook assumes the entire setup is in place (skills installed, MCP fork live, identity layer set, sound bank started). For the very first track you'll only have 1-2 K-XXX patches built — that's fine, use stock instruments for the rest.

## Pre-flight (5 min)

Before sitting down to make music:

- [ ] Computer is on, Ableton is closed
- [ ] No urgent obligations for the next 2-3 hours
- [ ] Headphones / monitors at known reference volume
- [ ] Water nearby
- [ ] Phone on Do Not Disturb

**The most underrated step:** *Don't open Ableton yet.* Open Claude Code first, read [[ARTIST-PROFILE]], settle on the day's intent. Opening Ableton first invites random plugin-browsing and you lose the first 30 minutes.

## Phase 0 — Intent setting (10 min, in Claude Code)

In a fresh Claude Code session, ask Claude:

> *"I'm starting a new track today. Help me set intent."*

Claude will read [[ARTIST-PROFILE]] and [[MOMENTS-LIBRARY]] and propose a starting position. You provide:

- **Genre target** (pick from [[genres/INDEX]] — default to progressive-house unless drawn elsewhere)
- **Working tempo** (default 122, sometimes 124)
- **Key** (default A minor, sometimes F or D minor)
- **Mood / reference** (1 sentence + 1-3 reference tracks)
- **Constraint** (optional — "instrumental only", "with a vocal hook", "no breakdown longer than 32 bars", etc.)

Claude writes a starter `notes.md` based on your inputs. Save it to `/tmp/` or scratchpad for now — copies into the project folder once you create it.

## Phase 1 — Project setup (5 min)

In Windows / file explorer:

- [ ] Navigate to `D:\Ableton Projects\`
- [ ] Create new folder: `YYYY-MM - [Track Name or "Untitled"]\`
  - If unsure on name, use `Untitled` — rename later when the track tells you what it is
- [ ] (Optional) Create empty subfolders: `references/`, `stems/`, `bounces/`, `master/`, `artwork/`, `release/`

In Ableton:

- [ ] Open Ableton Live
- [ ] File → New Live Set
- [ ] File → Save Live Set As → save to the new folder as `[Name].als`

In Claude Code:

- [ ] Tell Claude: *"Project folder is `D:\Ableton Projects\2026-06 - [Name]`. Apply the prog template."*

Claude does (using new MCP tools):

1. Sets tempo to 122 (or your chosen value)
2. Renames the 4 default tracks to KICK / TOP DRUMS / VOCAL FX / NOISE RISER
3. Creates 6 additional MIDI tracks: PERC / BASS-ROLL / SUB / PLUCK / PADS-LONG / PADS-AIR
4. Loads instruments: Drum Sampler / Drum Rack ×2 / Drift / Operator / Serum 2 / Drift / Wavetable
5. Creates 3 return tracks: Long Plate / Dotted Delay / Atmos Wash
6. Loads ValhallaVintageVerb / ValhallaDelay / ValhallaSupermassive on the returns
7. Deploys master chain: Pro-Q 4 → Pro-C 2 → Saturn 2 → Pro-L 2 (per [[MASTER-CHAIN]])
8. Reports done

Save Ableton (Cmd/Ctrl+S).

Save `notes.md` into the project folder.

## Phase 2 — Find the seed (30-60 min)

The first idea is sacred. Don't force.

Pick ONE entry point:

### Option A: Start with rhythm
1. Click KICK track
2. Browse Live's drum samples to find a kick that fits the genre (per [[genres/INDEX]]'s recommendations)
3. Write a kick pattern on bar 1 (4-on-the-floor for prog/melodic techno)
4. Add a clap or rim on 2 and 4
5. Add a closed hi-hat on every 8th
6. Loop scene 1 (4 bars)
7. Listen for 5 min — does it groove?

### Option B: Start with harmony
1. Click PADS-LONG track (Drift or Analog)
2. Browse synth presets — find a warm pad
3. Write a 4-chord progression in your chosen key (default Am → F → C → G)
4. Each chord = 1 bar
5. Loop scene 1
6. Listen — does the harmony move you?

### Option C: Start with a sample
1. Browse `D:\Presets, Samples and Loops` per [[SAMPLES.md]]'s recommendations for your genre
2. Drag a loop into a slot on TOP DRUMS or VOCAL FX
3. Find the pulse
4. Loop scene 1
5. Listen — is there a track hiding in this sample?

### Option D: Use Klimper to generate
1. Open polydigm Klimper on a MIDI track
2. Set key + scale + tempo
3. Generate a few melodic phrases
4. Pick the one that resonates
5. Drag it to PLUCK track (Serum 2)
6. Loop scene 1

**Whichever option:** the rule is *get to a 4-bar loop you'd listen to 10 times.* If after 60 minutes you don't have one, stop trying to make THIS track today — open `MOMENTS-LIBRARY` and write down 1 new entry instead, then close Ableton. Force = bad track.

## Phase 3 — Build the loop (60-90 min)

You have a seed (Phase 2). Now build it into a 4-bar loop with the full Kyle stack:

- [ ] **Drums** layer: kick + hat + perc loop. If genre is prog, add an off-beat open hat on 2.5 and 4.5
- [ ] **Bass** layer: K-002 (Bass Roll Dark) playing root of chord progression in 8ths or 16ths
- [ ] **Sub** layer: K-001 (Sub Pure) playing held root notes (whole bar each)
- [ ] **Pad** layer: K-007 (Pad Lush Long) playing chord triads, slow attack
- [ ] **Lead/Pluck** layer: K-004 (Pluck Modular Bright) with arp pattern (build later — leave empty for now)

If a K-XXX patch isn't built yet, use stock Drift / Wavetable / Analog with a factory preset that's close.

Loop scene 1. Listen for 10 min. Tweak. Listen again.

**Don't move on until the 4-bar loop feels like Kyle.** This is the most important moment of the entire track.

## Phase 4 — First milestone save (5 min)

When the loop is locked:

- [ ] Save Ableton (Cmd/Ctrl+S)
- [ ] Add entry to `notes.md`:
  ```
  ## Decisions log
  - [Today's date]: locked the seed loop. Bass = K-002 on Am-F-C-G. Pad = K-007 same. Drums = 4-on-floor + off-beat open hats.
  ```
- [ ] Render a quick 30-sec preview: File → Export Audio → MP3 at 192 kbps → save to `bounces/[date] - seed loop.mp3`
- [ ] (Optional) Send the bounce to your phone, listen on different speakers, take 10 minutes away. If it still feels right when you come back, continue. If it doesn't, save this version, mark it shelved in notes.md, start tomorrow with a different seed.

## Phase 5 — Arrange (60-120 min)

Use the [[arrangement-coach]] skill OR work manually. Standard prog/melodic-techno structure:

| Bars | Section | What's in it |
|--|--|--|
| 0-32 | Intro 1 (kick + hats only) | Just drums |
| 32-64 | Intro 2 (+bass + sub) | Drums + bass |
| 64-96 | Build (+pads) | Add the pad. **Deploy "the breath" 1 bar before bar 96.** |
| 96-128 | First drop | Full mix + lead |
| 128-160 | Verse / continuation | Vary slightly |
| 160-192 | Breakdown (kick out) | Pad + lead + atmospheric layers only |
| 192-224 | Build back | Bring drums back gradually |
| 224-256 | Second drop / outro | Often the emotional peak |
| 256-288 | Outro | Strip back to drums + 1 element |

Deploy "the breath" (K-010 Noise Riser, per [[SIGNATURE-MOVE]]) at every section change.

Use `duplicate_to_arrangement` MCP tool to copy the Session loop into the Arrangement view at each beat position.

## Phase 6 — Listen + iterate (30 min)

- [ ] `switch_to_arrangement_view`
- [ ] Play the full arrangement from bar 0 to end
- [ ] Take notes on what's wrong:
  - Bass too quiet at 2:30?
  - Pad doesn't change enough?
  - Breakdown too long?
  - Drums get boring at 1:30 — need a fill?
- [ ] Fix the most egregious 3 issues; ignore the rest for today

## Phase 7 — Stop. Save. Step away. (5 min)

- [ ] Save Ableton (Cmd/Ctrl+S)
- [ ] Render a full-length bounce: File → Export Audio → MP3 192kbps → `bounces/[date] - rough mix v1.mp3`
- [ ] Update `notes.md`:
  ```
  ## Decisions log
  - [Date]: rough arrangement done. 6 minutes. Drops at 0:32 and 4:40.
  ## Open questions
  - Bass too quiet from 2:30 onward
  - Breakdown might need to be 4 bars longer
  ```
- [ ] Close Ableton
- [ ] **Don't listen to the bounce for 24 hours.** Fresh ears tomorrow find everything.

## Day 2+: refinement loop (60-90 min per session)

For each subsequent session:

1. Listen to yesterday's bounce on a different system (car / phone / kitchen speakers)
2. Open Ableton
3. Read `notes.md` "Open questions"
4. Tackle 2-3 specific issues per session
5. Re-render to `bounces/`
6. Update `notes.md`

Most prog tracks need **5-10 sessions** before "done." That's normal. Don't rush.

## Mastering (when ready)

When the track feels done:

- [ ] Listen to the latest bounce alongside 3 reference tracks (per [[MOMENTS-LIBRARY]]) — do they feel like they belong together?
- [ ] Open Live, ensure master chain is deployed per [[MASTER-CHAIN]]
- [ ] Check Pro-L 2 LUFS reading:
  - Aim for -14 LUFS integrated for streaming master
- [ ] Render 4 versions per [[PROJECT-FOLDER.md]]:
  - `master streaming -14LUFS.wav`
  - `master DJ -10LUFS.wav` (boost Pro-L 2 gain by 4 dB, re-render)
  - `master club -8LUFS.wav` (boost another 2 dB)
  - `pre-master no-chain.wav` (disable master chain, render)
- [ ] Save all 4 into `master/` subfolder
- [ ] Update `notes.md` → Status: Mastering / Released

## Release (when distributing)

- [ ] Fill in `release/metadata.md` per [[PROJECT-FOLDER.md]]
- [ ] Create artwork at all required sizes → save to `artwork/`
- [ ] Upload to distributor (Distrokid / Amuse / etc.)
- [ ] Update Project Ledger ([[PROJECT-FOLDER.md]] → "Project ledger") to "Released" status

## Common failure modes (avoid these)

- **Spending Phase 1 (setup) doing Phase 2 (creative).** Set up. Don't browse plugins until you have intent.
- **Trying to "finish" in one session.** Most tracks need 5-10 sessions. Pace yourself.
- **Comparing your seed loop to a finished prog track.** It will feel bare. That's because finished tracks have 30+ hours of work in them.
- **Skipping the master chain "because it might color my mix."** Wrong way around — your mix should be COLORED by the master chain because that's the consistent finished sound.
- **Not saving / not rendering bounces.** Render at every milestone. Recovery from a corrupted .als is impossible if you didn't render.
- **Listening only on the system you produced on.** Always cross-check on phone, car, kitchen.
- **Ignoring `notes.md` for "real work."** The notes file IS real work. It captures decisions you'll regret losing.

## Eject button — when to abandon

If at any point you realize this track isn't working:

- **Phase 2 fail (no seed):** abandon TODAY's attempt. Spend the time updating MOMENTS-LIBRARY instead. Come back fresh tomorrow.
- **Phase 4 fail (loop doesn't feel right after milestone save):** mark the project "shelved" in notes.md and Project Ledger. Don't delete — mine it later for ideas.
- **Phase 6+ fail (arrangement won't gel):** save what you have. Open a fresh project. Try the seed loop in a different key or tempo. The original WIP stays in shelved status.

Not every session produces a finished track. Most don't. Discipline ≠ stubbornness.

## When the runbook itself needs updating

After 3-5 tracks, audit:
- What steps did I always skip?
- What steps did I add manually that aren't here?
- What surprises did I encounter?

Update this file with what you learned. The runbook gets better as you make music. The first version (this one) is a hypothesis.
