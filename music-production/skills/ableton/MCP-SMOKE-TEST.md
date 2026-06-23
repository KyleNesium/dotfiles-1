# MCP Smoke Test — verify all 28 tools

After deploying changes to the MCP fork (or after a fresh `install.sh` on a new machine), run this protocol to verify every tool actually works. Catches bugs BEFORE they surface mid-production.

## When to run

- After every `bash install.sh`
- After every Claude Code restart following an MCP fork change
- Before relying on a new tool for a real track
- After an Ableton update (Live API can shift)

## How to run

In a fresh Claude Code session, ask Claude:

> *"Run the MCP smoke test from `~/.claude/skills/ableton/MCP-SMOKE-TEST.md`. Report pass/fail per tool."*

Claude reads this file and executes the sequence below, reporting results.

## Prerequisites

1. Ableton Live is running with an EMPTY session (File → New Live Set)
2. AbletonMCP is selected as a Control Surface (status bar: "Listening for commands on port 9877")
3. Default 4-track / 2-return Live default layout
4. Tempo at default 120 BPM

If the session isn't empty, the test will mutate state — make sure it's safe to use.

## The test sequence (28 tools across 6 phases)

### Phase 1 — Read state (5 tools, non-mutating)

**Goal:** confirm read-only tools work.

| Test | Call | Expected |
|--|--|--|
| 1 | `get_session_info()` | Returns tempo, tracks count, returns count, master info, song length |
| 2 | `get_track_info(track_index=0)` | Returns track 0 details (name, type, clips, devices) |
| 3 | `get_browser_tree(category_type='instruments')` | Returns instruments root with empty children list (root only) |
| 4 | `get_browser_items_at_path(path='instruments')` | Returns list with Drift, Analog, Wavetable, etc. |
| 5 | `get_arrangement_clips(track_index=0)` | Returns empty clip list for track 0 |

All 5 should return WITHOUT errors and with sensible data.

### Phase 2 — Original mutating tools (10 tools)

**Goal:** confirm legacy tools still work.

| Test | Call | Expected |
|--|--|--|
| 6 | `set_tempo(122)` | Tempo set to 122. Confirm via `get_session_info`. |
| 7 | `set_track_name(track_index=0, name='SMOKE-TEST')` | Track 0 renamed |
| 8 | `create_midi_track(index=-1)` | New MIDI track created at end |
| 9 | `load_instrument_or_effect(track_index=N, uri='query:Synths#Drift')` | Drift loaded on new track |
| 10 | `create_clip(track_index=N, clip_index=0, length=4)` | 4-beat MIDI clip in slot 0 |
| 11 | `add_notes_to_clip(track_index=N, clip_index=0, notes=[{pitch:60, start_time:0, duration:1, velocity:100, mute:false}])` | Note added |
| 12 | `set_clip_name(track_index=N, clip_index=0, name='test-clip')` | Clip renamed |
| 13 | `fire_clip(track_index=N, clip_index=0)` | Clip launches (audible — listen for synth note) |
| 14 | `stop_clip(track_index=N, clip_index=0)` | Clip stops |
| 15 | `load_drum_kit(track_index=other, rack_uri='query:Synths#Drum%20Rack', kit_path='drums')` | Drum Rack loaded with kit |

### Phase 3 — NEW return-track tool (1 tool)

**Goal:** confirm `create_return_track` works.

| Test | Call | Expected |
|--|--|--|
| 16 | `create_return_track(name='Long Plate')` | New return track created. Confirm via `get_session_info` showing return_track_count incremented. |

### Phase 4 — NEW track mixer tools (3 tools)

**Goal:** confirm volume / panning / send level tools work.

| Test | Call | Expected |
|--|--|--|
| 17 | `set_track_volume(track_index=0, value=0.75, track_type='regular')` | Track 0 volume set to 0.75 |
| 18 | `set_track_panning(track_index=0, value=0.25, track_type='regular')` | Track 0 pan to +25% (right) |
| 19 | `set_send_level(track_index=0, send_index=0, value=0.5, track_type='regular')` | Track 0 send A set to 0.5 |
| 19b | `set_track_volume(track_index=0, value=0.85, track_type='master')` | **Master volume** set — verify track_type='master' works |

### Phase 5 — NEW device parameter tools (2 tools)

**Goal:** confirm device parameter access works.

Prerequisite: track N has Drift loaded (from test 9).

| Test | Call | Expected |
|--|--|--|
| 20 | `get_device_parameters(track_index=N, device_index=0, track_type='regular')` | Returns Drift's full parameter list with names/values/ranges |
| 21 | `set_device_parameter(track_index=N, device_index=0, parameter_index=X, value=Y, track_type='regular')` | Where X is the index of "Filter Frequency" from the get result, Y is a different value. Param value changes. |
| 21b | `set_device_parameter(track_index=N, device_index=0, parameter_index=X, value=Y2, track_type='regular')` | Set back to original |

### Phase 6 — NEW chain-safe effect loading (1 tool, critical)

**Goal:** confirm `add_effect_to_track` actually APPENDS rather than replacing.

Prerequisite: track N has Drift loaded (1 device).

| Test | Call | Expected |
|--|--|--|
| 22 | `add_effect_to_track(track_index=N, uri='query:Plugins#VST3:FabFilter:Pro-Q%204', track_type='regular')` | Pro-Q 4 added AFTER Drift. `get_track_info` should show 2 devices: [Drift, Pro-Q 4]. |
| 22a | `get_track_info(track_index=N)` to verify | devices.length == 2 |
| 23 | `add_effect_to_track(track_index=master, uri='query:Plugins#VST3:FabFilter:Pro-L%202', track_type='master')` | Pro-L 2 loaded on MASTER track. (Master normally has no devices.) |
| 24 | `add_effect_to_track(track_index=0, uri='query:Plugins#VST3:FabFilter:Pro-R%202', track_type='return')` | Pro-R 2 loaded on return track 0 (the "Long Plate" we created in test 16) |

### Phase 7 — Arrangement view + playback (4 tools)

| Test | Call | Expected |
|--|--|--|
| 25 | `start_playback()` | Playback starts |
| 26 | `stop_playback()` | Playback stops |
| 27 | `switch_to_arrangement_view()` | Live switches to Arrangement |
| 28 | `set_arrangement_time(time=8.0)` | Playhead at beat 8 |

## Reporting

After the sequence, report:

```markdown
| Phase | Tools | Passed | Failed | Notes |
|--|--|--|--|--|
| 1. Read state | 5 | X | Y | … |
| 2. Original mutating | 10 | X | Y | … |
| 3. NEW return track | 1 | X | Y | … |
| 4. NEW mixer | 4 | X | Y | … |
| 5. NEW device params | 3 | X | Y | … |
| 6. NEW chain-safe | 4 | X | Y | … |
| 7. Arrangement+playback | 4 | X | Y | … |
| **Total** | **31** | | | |
```

Note: count is 31 calls testing 28 unique tools (some called twice for completeness).

## After the test

If ALL tools pass: setup is verified. You can produce with confidence.

If ANY fail: capture the error message verbatim. Common failure modes:

| Symptom | Likely cause | Fix |
|--|--|--|
| Tool not found | Old MCP server still cached | Restart Claude Code (`/exit` + `claude`) |
| Ableton connection refused | Remote Script not loaded | Re-select AbletonMCP in Preferences → Control Surfaces |
| `set_device_parameter` "parameter not enabled" | Trying to set a parameter Live considers read-only | Use a different parameter — some are non-automatable |
| `add_effect_to_track` replaced instead of appended | The fork's selected_device fix didn't deploy | Re-run `install.sh`; restart Ableton |
| Return track creation fails | Live API name changed | Check the Remote Script's `_create_return_track` against current Live API |
| Master track effect load fails | URI wrong | Use `get_browser_items_at_path` to discover the right URI |

## Cleanup after passing

```
# Optionally:
# - Delete the SMOKE-TEST track (track 0, renamed by test 7)
# - Delete the Drift track (track N, created by test 8)
# - Delete the Long Plate return (created by test 16)
# - Reset tempo (test 6 set it to 122)
# - Save the session as 'SMOKE-TEST.als' for future re-runs

# OR just close without saving and re-open a fresh Live set
```

## Adding tests for future MCP extensions

When new tools are added to the fork:

1. Add a Phase 8+ section with the test call + expected result
2. Update the total count at the top
3. Keep test order: read tools first (non-mutating), then mutating tools, then NEW capabilities last

Tests should be **idempotent where possible** — same input = same result whether run for the 1st or 10th time on a clean session.
