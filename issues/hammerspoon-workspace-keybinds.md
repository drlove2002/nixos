# macOS Workspace Keybinds — Hyprland Parity

**Goal:** `Option+1..0` switches spaces, `Option+Shift+1..0` moves windows between spaces — matching Hyprland muscle memory.

## Status: 90% complete

**Done:**
- Hammerspoon 1.1.1 derivation in `core/overlay/darwin-unstable.nix`
- HM module: `home/desktop/hammerspoon.nix` copies config via activation script
- Config lives at `~/.config/hammerspoon/init.lua`
- `~/.hammerspoon/` is a real directory (symlink breaks Hammerspoon)
- Accessibility permission granted
- Native macOS Mission Control shortcuts (keys 118-127) disabled so they don't fight

**What works:**
- `hs.spaces.gotoSpace(n)` — proven via startup diagnostic (cycled all 5 desktops)
- Hotkey callbacks fire (`hs.alert.show` appears)
- `hs.spaces.count()` doesn't exist → use `hs.spaces.allSpaces()[screenUUID]` and `#` instead
- For-loops break closure capture in hs.hotkey.bind → all binds must be explicit (no loops)

**What's broken:**
`gotoSpace()` called from within a hotkey callback silently no-ops. The API works when called from init, but not from a keypress handler.

## Next steps (to try)

1. **Timer wrapper** — wrap `gotoSpace` in `hs.timer.doAfter(0.05, ...)`. If this works, the issue is runloop timing (Hammerspoon needs to return control to the event loop before the space switch takes effect). Test config already deployed to `~/.hammerspoon/init.lua`.

2. **If timer fails** — synthesize native macOS shortcut: `hs.eventtap.keyStroke({"ctrl"}, "3")` to send `Ctrl+3` (native macOS "switch to Desktop 3" shortcut). This bypasses Hammerspoon's space API entirely.

3. **If both fail** — use AppleScript: `hs.task.new("/usr/bin/osascript", ...)` with `tell app "System Events" to key code 20 using control down`.

## Files
- `/Users/sudiproy/.config/nixos/core/overlay/darwin-unstable.nix` — hammerspoon derivation
- `/Users/sudiproy/.config/nixos/core/overlay/hammerspoon.nix` — package derivation
- `/Users/sudiproy/.config/nixos/home/desktop/hammerspoon.nix` — HM module
- `/Users/sudiproy/.config/nixos/home/darwin.nix` — imports hammerspoon module
- `/Users/sudiproy/.config/hammerspoon/init.lua` — **canonical config**
- `/Users/sudiproy/.hammerspoon/init.lua` — deployed copy

## Rebuild
```bash
cd ~/.config/nixos && sudo darwin-rebuild switch --flake .#macbook
```
HM activation automatically copies `~/.config/hammerspoon/init.lua` → `~/.hammerspoon/init.lua`.

## Diagnostics
```bash
# View config load errors
cat ~/.hammerspoon/console.log
# System log (Lua errors)
log show --predicate 'process == "Hammerspoon"' --last 2m | grep -i error
# Restart Hammerspoon
killall Hammerspoon && sleep 1 && open /Applications/Hammerspoon.app
```
