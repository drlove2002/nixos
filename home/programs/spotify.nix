{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  macExtDir = "spicetify/Extensions";

  # Fetch community extensions from GitHub (macOS only)
  adblock = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/CharlieS1103/spicetify-extensions/main/adblock/adblock.js";
    hash = "sha256-Uj8afW1sAKUKkUwF88JQrD2U+PJf8q3bG+7IF0e8tpk=";
  };
  hidePodcasts = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/theRealPadster/spicetify-hide-podcasts/main/hidePodcasts.js";
    hash = "sha256-cn5aL5E39L536sg9I0oM6FjF1hjn/1YRam3vAXk/w/g=";
  };
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  # Linux: spicetify-nix wraps the nix Spotify package
  programs.spicetify = lib.mkIf pkgs.stdenv.hostPlatform.isLinux (let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
      keyboardShortcut
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
    ];
    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      pointer
    ];
  });

  # macOS: spotify via homebrew, extensions via home-manager files
  home.file = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    "${macExtDir}/adblock.js".source = adblock;
    "${macExtDir}/hidePodcasts.js".source = hidePodcasts;
  };

  home.activation = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    applySpicetify = lib.hm.dag.entryAfter ["linkGeneration"] ''
      if ! command -v spicetify &>/dev/null; then
        echo "spicetify-cli not found — skipping spotify mod" >&2
        exit 0
      fi

      SPICE_EXT="$HOME/.config/spicetify/Extensions"

      # Community extensions from home-manager files are already symlinked.
      # Built-in extensions ship with spicetify-cli — symlink them for
      # a flat extension directory spicetify expects.
      BUILTIN_EXT="$(brew --prefix spicetify-cli 2>/dev/null)/libexec/Extensions"
      if [ -d "$BUILTIN_EXT" ]; then
        for ext in keyboardShortcut.js shuffle+.js; do
          if [ ! -L "$SPICE_EXT/$ext" ] && [ -f "$BUILTIN_EXT/$ext" ]; then
            ln -sf "$BUILTIN_EXT/$ext" "$SPICE_EXT/$ext"
          fi
        done
      fi

      # Configure all extensions
      spicetify config extensions "adblock.js|hidePodcasts.js|keyboardShortcut.js|shuffle+.js" 2>/dev/null || true

      # Backup if needed, then apply
      if spicetify backup apply 2>/dev/null; then
        # Spicetify patches break macOS code signing — re-sign ad-hoc
        xattr -cr /Applications/Spotify.app 2>/dev/null || true
        sudo codesign --force --deep --sign - /Applications/Spotify.app 2>/dev/null || true
      else
        echo "spicetify backup/apply failed" >&2
      fi
    '';
  };
}
