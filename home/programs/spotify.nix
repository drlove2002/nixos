{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

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
      adblock hidePodcasts shuffle keyboardShortcut
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases ncsVisualizer
    ];
    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart pointer
    ];
  });

  home.packages = lib.mkIf isDarwin [ pkgs.spicetify-cli ];

  home.file = lib.mkIf isDarwin {
    "spicetify/Extensions".source = spiceExtensions;
  };

  home.activation = lib.mkIf isDarwin {
    applySpicetify = lib.hm.dag.entryAfter ["linkGeneration"] ''
      export PATH="/opt/homebrew/bin:$PATH"
      SPOTIFY="/Applications/Spotify.app"
      XPUI_SPA="$SPOTIFY/Contents/Resources/Apps/xpui.spa"

      command -v spicetify &>/dev/null || { echo "spicetify-cli not found — skipping" >&2; exit 0; }
      [ -d "$SPOTIFY" ] || { echo "Spotify.app not found — skipping" >&2; exit 0; }

      # Ensure xpui.spa exists — SpotX needs the packed file, not the extracted dir
      if [ ! -f "$XPUI_SPA" ]; then
        spicetify restore 2>/dev/null || true
        # If still no spa, bootstrap it
        if [ ! -f "$XPUI_SPA" ]; then
          spicetify backup apply 2>/dev/null || true
          spicetify restore 2>/dev/null || true
        fi
      fi

      [ -f "$XPUI_SPA" ] || { echo "xpui.spa unavailable after restore — skipping" >&2; exit 0; }

      # Download SpotX
      SPOTX="/tmp/spotx.sh"
      [ -f "$SPOTX" ] || curl -sSL "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/main/spotx.sh" -o "$SPOTX" 2>/dev/null || true

      # Patch with SpotX (adblock + block updates)
      [ -f "$SPOTX" ] && bash "$SPOTX" -f -B 2>/dev/null || true

      # Back up the patched xpui.spa and apply extensions
      spicetify config extensions "hidePodcasts.js|keyboardShortcut.js|shuffle+.js" 2>/dev/null || true
      spicetify backup 2>/dev/null || true
      spicetify apply 2>/dev/null || true

      # Re-sign
      xattr -cr "$SPOTIFY" 2>/dev/null || true
      codesign --force --deep --sign - "$SPOTIFY" 2>/dev/null || true
    '';
  };
}
