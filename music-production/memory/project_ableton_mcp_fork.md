---
name: project-ableton-mcp-fork
description: "Local fork of ahujasid/ableton-mcp at ~/workspace/ableton-mcp with 7 added MCP tools for mixing, sends, returns, device params, and chain-safe effect loading. ~/.claude.json points at this fork instead of uvx."
metadata: 
  node_type: memory
  type: project
  originSessionId: 1e32d402-97b1-43dd-8975-f5f014d4f407
---

The Ableton MCP server is a **local fork** at `~/workspace/ableton-mcp/`. The user's `~/.claude.json` runs it via `uv run --directory ~/workspace/ableton-mcp ableton-mcp` instead of the upstream `uvx ableton-mcp`.

**Why:** The upstream community MCP server (ahujasid/ableton-mcp 1.2.0) was missing capabilities needed for end-to-end music production: no return-track creation, no master-track effect loading, no chain-safe effect appending (load_instrument_or_effect would replace rather than chain — e.g. Rhythmizer Ultra replaced the Drum Rack on PERC track), no track volume/pan/send level control, no device parameter control. Surfaced 2026-06-23 mid-template-build.

**Added tools (both `__init__.py` Remote Script side AND `server.py` MCP side):**
1. `create_return_track(name)` — Live API: `song.create_return_track()`
2. `set_track_volume(track_index, value, track_type)` — track_type: regular | return | master
3. `set_track_panning(track_index, value, track_type)`
4. `set_send_level(track_index, send_index, value, track_type)`
5. `set_device_parameter(track_index, device_index, parameter_index, value, track_type)`
6. `get_device_parameters(track_index, device_index, track_type)` — returns full param list with ranges
7. `add_effect_to_track(track_index, uri, track_type)` — forces `selected_device = devices[-1]` before `browser.load_item()` so Live appends instead of replacing. Use for chained effects, master chains, returns FX.

**How to apply:** Use these tools freely for full template/mix work. The Remote Script is deployed at `C:\ProgramData\Ableton\Live125suite\Resources\MIDI Remote Scripts\AbletonMCP\__init__.py` AND `C:\Users\the-k\AppData\Roaming\Ableton\Live 12.2.5\Preferences\User Remote Scripts\AbletonMCP\__init__.py`. If Live updates and the Remote Script gets wiped, re-deploy from `~/workspace/ableton-mcp/AbletonMCP_Remote_Script/__init__.py`.

**Rebuild/update protocol:** Edit both files in `~/workspace/ableton-mcp/`, then re-copy the Remote Script to ProgramData. Restart Live (deselect/reselect Control Surface) to reload script. Restart Claude Code to reload MCP server (it caches tool schemas at startup).

**Backup of original config:** `~/.claude.json.bak-<unix-timestamp>` files preserve the previous uvx-based config in case rollback is needed.
