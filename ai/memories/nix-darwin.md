# Memory: Nix on this machine (macOS)

Durable notes about the local nix setup, kept out of the portable shared AI repo.

## Setup

- nix (with flakes) manages system + user environment via `~/.config/nixos`.
- Uses nix-darwin + home-manager (inline, not standalone). Hosts live under `hosts/`.
- Username on this machine is `love`; system config targets the macOS host.

## Operating habits

- The user rebuilds with `darwin-rebuild switch` (aliased) only when they choose to.
  Never trigger a switch unprompted.
- Tooling for a project is best entered via `nix develop` when the project ships a
  dev shell, rather than installing globally.
- When nix owns a config, the user edits the nix source, not the symlinked target.

## Boundaries

- nix is local to this machine. The shared `~/.config/ai` config is used on other machines
  too and must not assume nix exists. Machine-specific instructions belong in this overlay
  (`~/.config/nixos/ai/`), linked into the AI repo as gitignored `local-*` paths.
- No remote/production mutation without explicit approval, consistent with global rules.
