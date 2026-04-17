# AGENTS.md

This file provides guidance to AI coding agents working with code in this repository.

## What this is

A NixOS configuration using flakes, Home Manager (inline, not standalone), and Stylix for system-wide theming. Single host (`pc`) with username `love`.

## Key commands

```bash
# Rebuild and switch (most common operation)
nb                          # alias for: sudo nixos-rebuild switch --flake ~/.config/nixos

# Update all flake inputs and prepare a new boot generation
nbu                         # helper script: update flake inputs, build, and install as next boot generation

# Garbage collect old generations
ngc                         # alias for: sudo nix-collect-garbage -d

# Format Nix files (use alejandra, not nixpkgs-fmt)
alejandra .

# Check Nix syntax without building
nix flake check
```

## Architecture

```
flake.nix               # Entry point — defines inputs and single nixosConfigurations.nixos output
hosts/pc/               # Host-specific config; wires together core + home-manager
core/                   # NixOS system-level modules
  configs/              # Hardware/system: boot (lanzaboote/Secure Boot), GPU, audio, network, user, disks
  overlay/              # nixpkgs overlays: unstable channel as pkgs.unstable, custom maple-mono package
  programs/             # System-level programs: wayland, steam, VM, DB, services, etc.
home/                   # Home Manager config for user "love"
  programs/             # User programs: browser (Zen), VSCode, Neovim, Discord (nixcord), dev tools, gaming
  shell/                # Shell config: zsh + oh-my-zsh, aliases, env vars, kitty terminal, starship
  desktop/              # Hyprland WM + quickshell bar, wofi, swaync, eww, hyprlock/hypridle
assets/                 # wallpaper.jpg used by Stylix
```

## Important patterns

**Two nixpkgs channels:** `nixpkgs` (stable 25.11) is the default; `pkgs.unstable` accesses nixos-unstable via overlay. Stylix and nix-vscode-extensions follow unstable.

**Stylix theming:** Kanagawa color scheme applied system-wide via `core/configs/style.nix`. Most apps inherit automatically (`autoEnable = true`). Individual targets can be disabled with `stylix.targets.<name>.enable = false` (e.g. hyprland/hyprlock manage their own theme).

**Out-of-store symlinks for mutable configs:** Desktop configs (hypr, wofi, swaync, mpv, eww, quickshell) and shell scripts are symlinked with `mkOutOfStoreSymlink` so they can be edited without a rebuild. Config files live in:
- `home/desktop/configs/` → `~/.config/{hypr,wofi,swaync,mpv,eww}`
- `home/desktop/quickshell/configs/` → `~/.config/quickshell`
- `home/shell/scripts/bin/` → `~/.local/bin/`

**Formatter:** Use `alejandra` for Nix formatting (installed in `home/programs/dev.nix`).

**Nix LSP:** `nixd` is the language server (also in `dev.nix`).

**Secrets/env vars:** Loaded at shell startup from `~/.config/.env` (not tracked in git).

**Generic RAG tools:** Use `rag` for local RAG operations shared across agents. The canonical home is `~/.config/ai/rag`.
- `rag query "<text>"` — search indexed workspaces
- `rag index-here` — index the current repo
- `rag index-path /path/to/repo` — index a specific repo
- `rag index-all` — refresh all registered workspaces

**Lanzaboote Secure Boot:** Replaces systemd-boot; uses `/var/lib/sbctl` for PKI. Don't enable `systemd-boot` directly.

## Flake inputs of note

- `stylix` — system-wide theming (follows unstable)
- `home-manager` — release-25.11 branch
- `lanzaboote` — Secure Boot
- `nixcord` — Discord/Vencord config via Home Manager
- `codex-cli-nix` — Codex CLI flake
- `quickshell` — custom shell/bar (from outfoxxed's git)
- `zen-browser`, `spicetify-nix`, `nix-vscode-extensions`, `hyprland`
