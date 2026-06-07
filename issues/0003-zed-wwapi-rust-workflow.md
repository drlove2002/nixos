---
id: 0003
title: Add Zed project config for wwapi
kind: enhancement
status: ready-for-agent
slice_type: AFK
blocked_by:
  - 0002
created: 2026-05-07
---

## Parent

`issues/0001-prd-zed-worldflow.md`

## What to build

Add `.zed` configuration for the Rust repo `wwapi` so Zed understands the build target, language server setup, and common developer tasks.

### Files to change

- `/home/love/Projects/worldwide/wwapi/.zed/settings.json` new
- `/home/love/Projects/worldwide/wwapi/.zed/tasks.json` new

### Repo context to honor

- `/home/love/Projects/worldwide/wwapi/Cargo.toml`
- `/home/love/Projects/worldwide/wwapi/.cargo/config.toml`
- `/home/love/Projects/worldwide/wwapi/.vscode/settings.json`
- `/home/love/Projects/worldwide/wwapi/.vscode/launch.json`
- `/home/love/Projects/worldwide/wwapi/.envrc`

### Config goals

- Make rust-analyzer resolve the workspace correctly.
- Keep Zed pointed at the MUSL target used by the repo.
- Match the Rust formatting and check workflow used in the repo.
- Add tasks for build/test/clippy flows that are useful in Zed.
- Preserve the existing linker and target assumptions from `.cargo/config.toml`.

### Likely task surface

At minimum, expose tasks for:
- cargo check/build
- cargo test
- cargo clippy

If the existing VS Code debug setup can be translated cleanly into Zed debugger config, include it. If not, keep this slice focused on editor settings and tasks.

## Acceptance criteria

- [ ] `wwapi/.zed/settings.json` configures the Rust workspace correctly.
- [ ] `wwapi/.zed/tasks.json` exposes useful Rust workflow commands.
- [ ] Zed opens `wwapi` without rust-analyzer misdetecting the workspace.
- [ ] The repo's MUSL target and linker assumptions remain intact.
- [ ] The config stays minimal and matches the repo's current toolchain.

## Blocked by

- `issues/0002-zed-global-home-manager-module.md`
