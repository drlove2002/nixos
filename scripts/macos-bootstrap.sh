#!/usr/bin/env bash
set -euo pipefail

# === macOS Nix Bootstrap ===
# Run this on a fresh Mac to get Nix + nix-darwin + pi running.

# 1. Install Nix (multi-user)
if ! command -v nix &>/dev/null; then
  echo "Installing Nix..."
  sh <(curl -L https://nixos.org/nix/install)
  # Source nix
  if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  fi
fi

# 2. Enable flakes
if ! grep -q 'experimental-features' /etc/nix/nix.conf 2>/dev/null; then
  echo "Enabling flakes..."
  echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf
fi

# 3. Install pi now — we don't need the full darwin config yet
if ! command -v pi &>/dev/null; then
  echo "Installing pi..."
  nix profile install github:numtide/llm-agents.nix#pi
fi

# 4. Clone nixos config (if not already)
if [ ! -d "$HOME/.config/nixos" ]; then
  echo "Cloning nixos config..."
  git clone git@github.com:drlove2002/nixos.git "$HOME/.config/nixos"
fi

# 5. Copy AI config from NixOS PC (if you have a backup)
AI_BACKUP="$HOME/.config/ai-backup.tar.zst"
if [ -f "$AI_BACKUP" ] && [ ! -d "$HOME/.config/ai" ]; then
  echo "Restoring AI config from backup..."
  mkdir -p "$HOME/.config/ai"
  tar --zstd -xf "$AI_BACKUP" -C "$HOME/.config/ai"
fi

if [ ! -d "$HOME/.config/ai" ]; then
  echo "NOTE: No ~/.config/ai found."
  echo "Copy it from your NixOS PC with:"
  echo "  rsync -avz nixos:~/.config/ai/ ~/.config/ai/"
  echo ""
  echo "Or archive on NixOS first:"
  echo "  cd ~/.config && tar --zstd -cf ai-backup.tar.zst ai"
  echo "  scp ai-backup.tar.zst mac:~/"
fi

echo ""
echo "Done. Pi is installed and AI config is linked."
echo "To build the full darwin system:"
echo "  cd ~/.config/nixos"
echo "  nix build .#darwinConfigurations.macbook.system"
echo "  ./result/sw/bin/darwin-rebuild switch --flake .#macbook"
echo ""
echo "Then use 'nb' to rebuild whenever you change the config."
