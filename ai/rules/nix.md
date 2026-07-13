# Nix (Local Capability — macOS)

This rule applies only on machines where nix is installed. nix is an **optional local
capability**, not a global assumption — most shared AI config stays provider/system-neutral
and must keep working on machines without nix.

## Source of truth

- System configuration for this machine lives in `~/.config/nixos` (flake + home-manager).
- Treat that repo as the single source of truth for what is installed and how it is configured.
- Inspect the relevant nix file (`flake.nix`, `hosts/*`, `home/*`) **before** proposing any
  system-level change. Read, don't guess.

## Don't fight the config

- If nix config owns a package, service, or dotfile, **do not** mutate system state via
  `brew`, manual edits to `/etc`, or ad-hoc install commands. Change the nix source instead.
- Respect out-of-store symlinks managed by home-manager — edit the source file in the repo,
  not the symlinked target, unless the user explicitly wants a local override.

## Rebuild discipline

- `darwin-rebuild switch` (or `nixos-rebuild switch` on Linux) changes the live system.
  Run it **only after explicit user approval**.
- Use `nix flake check` to validate syntax before proposing a switch.
- Prefer `nix develop` when a project provides a flake/dev shell rather than installing
  tooling globally.

## Safety

- No production or remote mutation without explicit approval (same bar as all other rules).
- Keep the shared `~/.config/ai` repo portable: never add machine-specific system-management
  instructions (e.g. "run darwin-rebuild switch") to shared tracked files. Put them here.
