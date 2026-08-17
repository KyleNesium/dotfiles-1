# Ableton MCP — what works, what doesn't, how to work around it

The user's MCP server is a **local fork** at `~/workspace/ableton-mcp/` (see [[project-ableton-mcp-fork]]). It exposes **28 tools** that talk to Ableton Live 12.2.5 through a Remote Script over `localhost:9877`.

## Tool inventory — what to use when

### Read state (cheap, no side effects)

| Tool | Use for |
|--|--|
| `get_session_info` | Tempo, time signature, track count, master, song length, playing state |
| `get_track_info(track_index)` | One track's name, clips, devices, mute/solo/arm |
| `get_arrangement_clips(track_index)` | Arrangement-view clips on a track |
| `get_browser_tree(category)` | Top-level categories (`instruments`, `audio_effects`, etc.) |
| `get_browser_items_at_path(path)` | Drill into the browser (e.g. `plugins/VST3/u-he`) |
| `get_device_parameters(track, device, track_type)` | All knobs on a device with current values + ranges. **Call before set_device_parameter to find the right index.** |

### Track operations

| Tool | Use for |
|--|--|
| `create_midi_track(index=-1)` | Add a MIDI track at the end (`-1`) or specific position |
| `set_track_name(track_index, name)` | Rename track |
| `set_track_volume(track_index, value, track_type)` | 0.0-1.0 nominal. `track_type`: `regular` \| `return` \| `master` |
| `set_track_panning(track_index, value, track_type)` | -1.0 left, 0.0 center, 1.0 right |
| `set_send_level(track, send_index, value, track_type)` | Feed to a return (A=0, B=1, ...) |
| `create_return_track(name)` | Spin up a Return track |

### Clip + MIDI

| Tool | Use for |
|--|--|
| `create_clip(track, slot, length)` | Empty MIDI clip in Session view (length in beats) |
| `create_audio_clip(track, slot, path)` | Audio clip from file. **Audio tracks only.** Live 12.0.5+ |
| `add_notes_to_clip(track, slot, notes[])` | Notes as `{pitch, start_time, duration, velocity, mute}` |
| `set_clip_name(track, slot, name)` | Rename clip |
| `fire_clip(track, slot)` | Launch a clip (Session view) |
| `stop_clip(track, slot)` | Stop a clip |
| `duplicate_to_arrangement(track, slot, destination_time)` | Copy Session clip into Arrangement |
| `set_arrangement_time(time)` | Move arrangement playhead |
| `switch_to_arrangement_view()` | Switch Live's main window |

### Instruments + effects

| Tool | Use for |
|--|--|
| `load_instrument_or_effect(track_index, uri)` | Load an instrument. **REPLACES existing devices on the track.** Use for instrument tracks. |
| `add_effect_to_track(track_index, uri, track_type)` | **Chain-safe** — appends after the last device. Use for: Rhythmizer-after-Drum-Rack, master chains (Pro-Q → Pro-C → Saturn → Pro-L), FX stacks on returns. `track_type`: `regular` \| `return` \| `master` |
| `load_drum_kit(track, rack_uri, kit_path)` | Drum Rack with a specific kit loaded |
| `set_device_parameter(track, device, param, value, track_type)` | Tweak a knob. Use after `get_device_parameters` to find the index. |

### Playback + tempo

| Tool | Use for |
|--|--|
| `set_tempo(tempo)` | Default to **122** for prog work |
| `start_playback()` | Play from Arrangement position OR fire active Session clips |
| `stop_playback()` | Stop all |

## Critical gotchas

### `load_instrument_or_effect` replaces — use `add_effect_to_track` for chaining
The OG tool calls Live's `browser.load_item()` which sometimes replaces (depending on whether Live thinks the plugin is an instrument or effect). For deterministic appending, use `add_effect_to_track` — it forces `selected_device = devices[-1]` before loading.

**Rule:** If a track already has an instrument and you want to add an effect, use `add_effect_to_track`. If the track is empty and you want a synth, use `load_instrument_or_effect`.

### Live's Python is on the main thread — calls can take ~1s each
Don't spam parallel calls on the same track. Different tracks in parallel is fine.

### Browser URIs come from `get_browser_items_at_path`
Don't construct URIs by hand. Always discover via the browser API. Common patterns:
- Stock instrument: `query:Synths#Drift`, `query:Synths#Operator`
- VST3 plugin: `query:Plugins#VST3:VENDOR:NAME`
- Folder URI navigation: `plugins/VST3/u-he` (use `/` separator)

### Default patches sound generic
Loaded instruments come with init patches — Drift, Analog, Wavetable, Operator all sound vanilla until the user browses to a preset. Pre-warn the user: *"That's the default patch — browse the preset folder for the actual sound."*

### Audio tracks ≠ MIDI tracks
- `create_midi_track` adds MIDI only
- No `create_audio_track` exposed (Live API exists but isn't wrapped). Workaround: use the 2 default audio tracks Ableton creates, or have the user add audio tracks manually.

### Master + return track access via `track_type` parameter
The new tools (`set_track_volume`, `set_track_panning`, `set_send_level`, `set_device_parameter`, `add_effect_to_track`) accept a `track_type` parameter:
- `regular` — the normal tracks (index = position in regular track list)
- `return` — return tracks (index = position in return track list, 0 = A)
- `master` — the master track (track_index is ignored)

### MIDI note format
```python
{"pitch": 60, "start_time": 0.0, "duration": 1.0, "velocity": 100, "mute": False}
```
- `pitch`: MIDI note number (C4 = 60, A4 = 69)
- `start_time`: beats from clip start (0.0 = first beat)
- `duration`: beats
- `velocity`: 0-127

### MIDI note useful conversions
- **Drum Rack** triggers: kick=C1 (36), snare=D1 (38), closed hat=F#1 (42), open hat=A#1 (46), clap=D1 (38)
- **Drum Sampler** trigger: usually C3 (60) by default, configurable
- **Bass register**: A1=33, F1=29, C2=36, G1=31 (for A-minor i-VI-III-VII rolling bass)
- **Pad register**: A3=57, C4=60, E4=64 (for Am triad mid-register)
- **Lead/pluck register**: A4=69 and up

## Capabilities NOT in the MCP

Things to ask the user to do manually:

- **Create audio tracks** — no MCP wrapper, must drag from browser
- **Save the session** — no MCP wrapper (`Ctrl+S` in Live)
- **Change view sizes, browser visibility, automation lanes** — no MCP access
- **Render/export audio** — no MCP wrapper
- **Modify clip envelopes / automation** — no MCP wrapper
- **Set quantize value, fixed grid** — no MCP wrapper
- **Modify groove pool** — no MCP wrapper

## Workflow patterns

### Pattern: Build a template from scratch
```
1. set_tempo(122)
2. set_track_name on existing default tracks
3. create_midi_track repeatedly for additional tracks (sequential, not parallel — race condition)
4. load_instrument_or_effect on each new track (parallel — different tracks)
5. create_return_track ×3
6. add_effect_to_track on master for the master chain (Pro-Q → Pro-C → Saturn → Pro-L)
7. add_effect_to_track on returns for VintageVerb/Delay/Supermassive
```

### Pattern: Write a 4-bar prog loop
```
1. create_clip(track, 0, 16)  # 4 bars * 4 beats
2. add_notes_to_clip(...)
3. set_clip_name(track, 0, "8th roll")
4. fire_clip on all tracks in scene 0
```

### Pattern: Mix a track
```
1. get_track_info to see device chain
2. add_effect_to_track to insert utility/EQ
3. get_device_parameters to find the knob
4. set_device_parameter to dial it in
5. set_send_level to push the track to a reverb return
```

### Pattern: Recover from "the wrong thing happened"
- Live has Cmd/Ctrl+Z undo. Tell the user to undo and try a different approach.
- The MCP has no "delete device" tool — workaround is to load_instrument_or_effect with a different URI to replace.

## When this file goes stale

If new tools get added to the local fork (`~/workspace/ableton-mcp/`), update this file. The Remote Script handler list is the source of truth — grep `^\s+def _handle\|elif command_type ==` to find them.
