---
id: 0002
title: Add Zed Home Manager module and global defaults
kind: enhancement
status: ready-for-agent
slice_type: AFK
blocked_by:
  - 0001
created: 2026-05-07
---

## Parent

`issues/0001-prd-zed-worldflow.md`

## What to build

Add a dedicated Home Manager module for Zed and register it in the home programs import list.

### Files to change

- `/home/love/.config/nixos/flake.nix`
- `/home/love/.config/nixos/home/programs/default.nix`
- `/home/love/.config/nixos/home/programs/zed.nix` new

### Global Zed configuration goals

- Enable `programs.zed-editor`.
- Choose the upstream flake package from `github:zed-industries/zed`, which satisfies Zed `>= 1.0.0`.
- Set `vim_mode = true`.
- Use `base_keymap = "None"` and a custom keymap layer that follows Neovim and LazyVim habits.
- Enable `load_direnv = "shell_hook"` so Zed picks up each repo's flake shell.
- Set `format_on_save = "on"` unless a repo needs to override it.
- Set `relative_line_numbers = true`.
- Keep the theme aligned with the desktop setup.
- Preinstall the language support needed for the worldwide repos: Rust, Nix, Python, TypeScript, TOML, Markdown.

### Suggested global settings shape

Use `programs.zed-editor.userSettings` for declarative JSON settings, `programs.zed-editor.extensions` for the initial extension list, and a declarative `keymap.json` for the Neovim-oriented bindings.

Keep the config small. Do not clone LazyVim, but do mirror the navigation and editing habits you actually use.

## Acceptance criteria

- [ ] `home/programs/default.nix` imports the new Zed module.
- [ ] Zed is installed declaratively through Home Manager.
- [ ] Zed launches with Vim mode enabled.
- [ ] Zed loads project shells through direnv.
- [ ] Zed uses a sane global theme and default editor settings.
- [ ] The initial extension list covers the languages used in `~/Projects/worldwide`.
- [ ] Neovim and Codium config remain unchanged.

## Blocked by

None.
