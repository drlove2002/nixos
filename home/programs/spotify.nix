{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  # All extension files fetched from their sources with pinned hashes.
  keyboardShortcut = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/spicetify/cli/v2.42.1/Extensions/keyboardShortcut.js";
    hash = "sha256-hQlJpCFF7Ju8ep4KcWRQ52ZO2SasF25jViUelh1HBO8=";
  };
  shuffle = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/spicetify/cli/v2.42.1/Extensions/shuffle+.js";
    hash = "sha256-3q/DI2tCs0gbRYOZjhFjzBFmn5/vtoNYA7YWNC1Zcj8=";
  };
  hidePodcasts = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/theRealPadster/spicetify-hide-podcasts/main/hidePodcasts.js";
    hash = "sha256-cn5aL5E39L536sg9I0oM6FjF1hjn/1YRam3vAXk/w/g=";
  };

  # Bundle non-adblock extensions (adblock handled via SpotX instead)
  spiceExtensions = pkgs.runCommand "spicetify-extensions" {
    inherit keyboardShortcut shuffle hidePodcasts;
  } ''
    mkdir -p $out
    cp "$keyboardShortcut" "$out/keyboardShortcut.js"
    cp "$shuffle" "$out/shuffle+.js"
    cp "$hidePodcasts" "$out/hidePodcasts.js"
  '';

in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = lib.mkIf (!isDarwin) (let
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

  home.packages = lib.mkIf isDarwin [ pkgs.spicetify-cli ];

  home.file = lib.mkIf isDarwin {
    "spicetify/Extensions".source = spiceExtensions;
  };

  home.activation = lib.mkIf isDarwin {
    applySpicetify = lib.hm.dag.entryAfter ["linkGeneration"] ''
      # Ensure spicetify-cli is in PATH (homebrew not on PATH during activation)
      export PATH="/opt/homebrew/bin:$PATH"
      if ! command -v spicetify &>/dev/null; then
        echo "spicetify-cli not found — skipping spotify mod" >&2
        exit 0
      fi
      if [ ! -f "/Applications/Spotify.app/Contents/Resources/Apps/xpui.spa" ]; then
        echo "Spotify xpui.spa not found — skipping" >&2
        exit 0
      fi

      SPOTX="/tmp/spotx.sh"
      SPOTX_URL="https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/main/spotx.sh"

      # Phase 1 — restore to clean state, apply SpotX adblock patches
      spicetify restore 2>/dev/null || true
      if [ ! -f "$SPOTX" ]; then
        curl -sSL "$SPOTX_URL" -o "$SPOTX" 2>/dev/null || true
      fi
      if [ -f "$SPOTX" ]; then
        bash "$SPOTX" -f 2>/dev/null || true
      fi

      # Phase 2 — back up the SpotX-patched xpui.spa, then apply extensions
      spicetify config extensions "hidePodcasts.js|keyboardShortcut.js|shuffle+.js" 2>/dev/null || true
      spicetify backup 2>/dev/null || true
      spicetify apply 2>/dev/null || true

      # Phase 3 — re-sign (modifications break the code signature)
      xattr -cr /Applications/Spotify.app 2>/dev/null || true
      codesign --force --deep --sign - /Applications/Spotify.app 2>/dev/null || true
    '';
  };
}
