---
id: 0001
title: PRD: Add Zed to the worldflow setup
kind: prd
status: accepted
blocked_by: []
created: 2026-05-07
---

## Problem Statement

You want Zed in the `~/Projects/worldwide` workflow without replacing the editors you already use. Neovim stays primary for general editing, Codium stays available, and Zed should fit the Rust, Python, and TypeScript repos in that workspace with sensible defaults.

## Solution

Add Zed as a declarative Home Manager app in the NixOS config, then layer project-specific `.zed` configuration into the `wwapi`, `wwbot`, and `wwpage` repos. Configure Zed for a Neovim-first workflow: Vim mode on, a keymap that follows LazyVim habits, repo-local tasks for build/test/run commands, and language settings that match each project's toolchain.

Target Zed `>= 1.0.0` only.

## User Stories

1. As a developer working in `~/Projects/worldwide`, I want Zed installed and configured declaratively so the editor is reproducible across rebuilds.
2. As a LazyVim user, I want Zed to keep Vim motions and preserve the shortcuts I already use so I do not fight the editor.
3. As someone switching between Rust, Python, and TypeScript repos, I want Zed to load the right language servers and formatters in each project.
4. As someone who uses `direnv` and Nix flakes, I want Zed to load each repo's environment automatically.

## Implementation Decisions

- Add a dedicated Home Manager module for Zed, rather than installing it as an unmanaged GUI package.
- Use the Home Manager `programs.zed-editor` module so settings and keymaps stay declarative.
- Keep Neovim as `$EDITOR` and keep the existing Codium alias untouched.
- Set Zed up as a Neovim-first editor: `vim_mode = true`, `base_keymap = "None"`, and a custom keymap layer that mirrors LazyVim habits.
- Load project environments through direnv so Zed sees each repo's flake shell.
- Keep repo-specific behavior in `.zed/` inside each project, not in the global Zed config.
- Target a Zed package at or above version `1.0.0`.
- Use the upstream Zed flake input from `github:zed-industries/zed` rather than the older nixpkgs package.

### Concrete files already identified

NixOS config:
- `/home/love/.config/nixos/home/programs/default.nix`
- `/home/love/.config/nixos/home/programs/zed.nix` new
- `/home/love/.config/nixos/home/shell/aliases.nix`
- `/home/love/.config/nixos/home/shell/envvar.nix`

Worldwide repos:
- `/home/love/Projects/worldwide/wwapi/.zed/settings.json` new
- `/home/love/Projects/worldwide/wwapi/.zed/tasks.json` new
- `/home/love/Projects/worldwide/wwbot/.zed/settings.json` new
- `/home/love/Projects/worldwide/wwbot/.zed/tasks.json` new
- `/home/love/Projects/worldwide/wwpage/.zed/settings.json` new
- `/home/love/Projects/worldwide/wwpage/.zed/tasks.json` new

Existing config that Zed should align with:
- `wwapi/.cargo/config.toml`
- `wwapi/Cargo.toml`
- `wwbot/pyproject.toml`
- `wwpage/tsconfig.json`
- `wwpage/package.json`
- `wwapi/.vscode/launch.json`
- `wwbot/.vscode/launch.json`
- `wwpage/.vscode/launch.json`

## Testing Decisions

- Verify Zed installs through Home Manager and launches from the desktop environment.
- Verify `load_direnv` lets Zed enter each repo shell with the right tools on PATH.
- Verify Rust, Python, and TypeScript language servers start in their repos.
- Verify the chosen keymap behaves the way you expect for the shortcuts you use most.
- Verify the repo-local tasks appear in Zed and run the right commands.

## Out of Scope

- Replacing Neovim or Codium.
- Recreating LazyVim feature for feature.
- Tuning Zed for unrelated repos outside `~/Projects/worldwide`.
- Adding AI provider setup unless you ask for it later.
