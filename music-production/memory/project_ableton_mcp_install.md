---
name: project-ableton-mcp-install
description: "AbletonMCP Remote Script must be installed under ProgramData/Live125suite/Resources/MIDI Remote Scripts, not the User Remote Scripts folder — Live 12.2.5 silently ignores the latter on this machine."
metadata: 
  node_type: memory
  type: project
  originSessionId: 1e32d402-97b1-43dd-8975-f5f014d4f407
---

The AbletonMCP Remote Script (community `ahujasid/ableton-mcp`) is installed at:
`C:\ProgramData\Ableton\Live125suite\Resources\MIDI Remote Scripts\AbletonMCP\__init__.py`

The User Remote Scripts copy at `C:\Users\the-k\AppData\Roaming\Ableton\Live 12.2.5\Preferences\User Remote Scripts\AbletonMCP\` is also present but Live's scanner silently rejected it — 0 mentions across the entire Log.txt history.

**Why:** Live 12.2.5 on this Windows install does not scan the User Remote Scripts folder for this script. The upstream README acknowledges this with "One of these should work, you might have to look" and lists ProgramData as Method 2. Files are byte-identical (md5 4b0db1e70dd18c16c749eeee0ef79874).

**How to apply:** If the AbletonMCP MCP tools fail to connect on `localhost:9877`, first check whether Live is running and AbletonMCP is selected in Preferences → Link, Tempo & MIDI → Control Surface. If the dropdown doesn't show AbletonMCP, re-copy the script to the ProgramData path and fully restart Live (not just close window — quit the process). MCP server is wired via `uvx ableton-mcp`, configured in `~/.claude.json`.
