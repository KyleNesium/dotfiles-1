# Master Chain — One-Call Deployment

Drops the Kyle master chain ([[MASTER-CHAIN]] spec) onto the current Ableton session's master track in a single sequence. Requires the new MCP server (post-Claude-Code-restart).

## Prerequisites

- Claude Code restarted with the local ableton-mcp fork loaded
- `mcp__ableton__add_effect_to_track` available (verify via ToolSearch)
- `mcp__ableton__set_device_parameter` available
- `mcp__ableton__get_device_parameters` available
- Ableton open with the target project

## The deployment sequence

Run as a 4-call batch:

```python
# 1. Pro-Q 4 (broad shape EQ)
add_effect_to_track(track_type='master', uri='query:Plugins#VST3:FabFilter:Pro-Q%204')

# 2. Pro-C 2 (bus glue)
add_effect_to_track(track_type='master', uri='query:Plugins#VST3:FabFilter:Pro-C%202')

# 3. Saturn 2 (warmth)
add_effect_to_track(track_type='master', uri='query:Plugins#VST3:FabFilter:Saturn%202')

# 4. Pro-L 2 (true peak limiter)
add_effect_to_track(track_type='master', uri='query:Plugins#VST3:FabFilter:Pro-L%202')
```

Then verify the master track has all 4 devices in order, and dial the parameters per [[MASTER-CHAIN]].

## Parameter dialing — for non-VST devices

Most FabFilter VST3 plugins don't expose their controls via Live's `parameters` API (they appear as a single "PluginDevice" with limited control). For these, the deploy protocol is:

1. Place the 4 FabFilter devices on master via `add_effect_to_track` calls above
2. Open Live, manually dial each device per the [[MASTER-CHAIN]] spec
3. **Right-click the chain → Group → name "Kyle Master"**
4. Save to user library: drag the rack to the browser → save as `Kyle Master.adg`

Subsequent projects: drag the `.adg` from the browser onto master. Zero re-dialing needed.

## First-time deployment (full flow)

Approximate time: 15 minutes (most is manual dialing in Live's UI).

```text
[t+0:00] add Pro-Q 4 to master (1 MCP call)
[t+0:01] add Pro-C 2 to master
[t+0:02] add Saturn 2 to master
[t+0:03] add Pro-L 2 to master
[t+0:04] open Pro-Q 4 in Live, manually dial bands per spec (~3 min)
[t+0:07] open Pro-C 2, dial parameters (~2 min)
[t+0:09] open Saturn 2, set Tape Subtle preset, drive 12% (~1 min)
[t+0:10] open Pro-L 2, set ceiling -0.3 dB TP, Modern style (~2 min)
[t+0:12] group all 4 → name "Kyle Master"
[t+0:13] drag to user library → save as Kyle Master.adg
[t+0:15] done. All future projects: drag the rack to master, instant deployment.
```

## Verification

After deployment:
1. Send some content through (e.g. fire the prog template loop)
2. Check Pro-L 2's GR meter — should sit at 0 to -1 dB on average, -3 to -6 dB on peaks
3. Check overall LUFS via Pro-L 2's built-in meter — should be in target range:
   - Streaming: -14 LUFS integrated
   - DJ pre-master: -10 LUFS integrated
   - Club: -8 LUFS integrated
4. If LUFS is too low: turn up Pro-L 2's gain (NOT the threshold — gain is the post-fader trim)
5. If LUFS is too high but GR is reasonable: you're inputting too hot. Pull master fader down 1-2 dB.

## When NOT to deploy

- **Mastering session for engineer hand-off:** ship pre-master without the chain.
- **Track explicitly aiming for non-Kyle sound:** skip the chain, note in project metadata.
- **Mid-mix when you're not ready for finishing:** the chain colors your decisions. Mix WITHOUT it first; bring it in for the final ~10% of the work.

## Re-dialing protocol

Every 6 months, A/B test the chain against your current taste:
1. Render a recent finished track with the current chain (Render A)
2. Disable the chain. Render again (Render B)
3. Listen to both on multiple systems (laptop speakers, headphones, monitors, car)
4. If you prefer Render A consistently → chain is working
5. If you prefer Render B (often) → time to re-dial

When re-dialing, change ONE device at a time and re-render. Don't overhaul all 4 at once — you'll lose the baseline.

## Companion: master-disable convenience

Add a `[Kyle Master OFF]` track to your template — a placeholder Audio Track that disables the master chain by routing master output to it (via Live's `Master Out` choice). Used for A/B testing your mix with vs without the chain. Toggle on/off mid-mix to hear the chain's contribution.

## Files this protocol depends on

- [[MASTER-CHAIN]] — the actual parameter values
- [[ARTIST-PROFILE]] — LUFS targets per release context
