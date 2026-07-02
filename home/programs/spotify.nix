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
      if ! command -v spicetify &>/dev/null; then
        echo "spicetify-cli not found — skipping spotify mod" >&2
        exit 0
      fi

      XPUI="/Applications/Spotify.app/Contents/Resources/Apps/xpui"
      XPUI_SPA="/Applications/Spotify.app/Contents/Resources/Apps/xpui.spa"

      # 1. Apply spicetify extensions (hidePodcasts, keyboardShortcut, shuffle+)
      spicetify config extensions "hidePodcasts.js|keyboardShortcut.js|shuffle+.js" 2>/dev/null || true
      spicetify backup apply 2>/dev/null || true

      # 2. Apply SpotX-style adblock patches to extracted JS files.
      #    These disable ad services at the code level and persist
      #    across spicetify apply as long as spicetify doesn't re-pack.
      #    Each patch targets a different ad vector.
      if [ -d "$XPUI" ]; then
        # Patch 1: block ad API endpoints (/ads/v1 → /abs/v1 etc.)
        perl -0777pi -w -e 's{/a\Kd(?=s(?:/v[12]|/v2/[ts]e))}{b}gs' "$XPUI"/*.js "$XPUI"/vendor*.js 2>/dev/null || true

        # Patch 2: billboard and leaderboard ads
        perl -0777pi -w -e 's{adsEnabled:!\K0}{1}s' "$XPUI"/*.js "$XPUI"/vendor*.js 2>/dev/null || true

        # Patch 3: disable ad cosmos (audio ads)
        perl -0777pi -w -e 's{(case .:|async enable\(.\)\{)(this\.enabled=.+?\(.{1,3},"audio"\))((;case 4:)?this\.subscription=this\.audioApi).+?this\.onAdMessage\)}{$1$3.cosmosConnector.increaseStreamTime(-100000000000)}s' "$XPUI"/*.js "$XPUI"/vendor*.js 2>/dev/null || true
      fi

      # 3. Re-sign (spicetify and patches both break the signature)
      xattr -cr /Applications/Spotify.app 2>/dev/null || true
      codesign --force --deep --sign - /Applications/Spotify.app 2>/dev/null || true
    '';
  };
}
