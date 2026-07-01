{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  # Community extensions — fetched from GitHub with pinned hashes
  adblock = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/CharlieS1103/spicetify-extensions/main/adblock/adblock.js";
    hash = "sha256-Uj8afW1sAKUKkUwF88JQrD2U+PJf8q3bG+7IF0e8tpk=";
  };
  hidePodcasts = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/theRealPadster/spicetify-hide-podcasts/main/hidePodcasts.js";
    hash = "sha256-cn5aL5E39L536sg9I0oM6FjF1hjn/1YRam3vAXk/w/g=";
  };

  # Single derivation bundling ALL extensions into one directory.
  # Built-in extensions come from nixpkgs spicetify-cli, community ones from fetchurl.
  # Everything resolves to nix-store paths — no brew or runtime path dependencies.
  spiceExtensions = pkgs.runCommand "spicetify-extensions" {
    inherit adblock hidePodcasts;
  } ''
    mkdir -p $out

    # Built-in extensions — from the nixpkgs spicetify-cli package
    cp "${pkgs.spicetify-cli}/libexec/Extensions/keyboardShortcut.js" "$out/"
    cp "${pkgs.spicetify-cli}/libexec/Extensions/shuffle+.js" "$out/"

    # Community extensions
    cp "$adblock" "$out/adblock.js"
    cp "$hidePodcasts" "$out/hidePodcasts.js"
  '';

in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  # Linux: spicetify-nix wraps the nix Spotify package
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

  # macOS: spotify via homebrew, extensions bundled above
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

      spicetify config extensions "adblock.js|hidePodcasts.js|keyboardShortcut.js|shuffle+.js" 2>/dev/null || true

      if spicetify backup apply 2>/dev/null; then
        # Spicetify patches break macOS code signing — re-sign ad-hoc
        xattr -cr /Applications/Spotify.app 2>/dev/null || true
        codesign --force --deep --sign - /Applications/Spotify.app 2>/dev/null || true
      else
        echo "spicetify backup/apply failed" >&2
      fi
    '';
  };
}
