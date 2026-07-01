{
  inputs,
  pkgs,
  lib,
  ...
}: {
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

  # macOS: spotify installed via homebrew cask, spicetify via homebrew formula
  home.activation = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    applySpicetify = lib.hm.dag.entryAfter ["linkGeneration"] ''
      if command -v spicetify &>/dev/null; then
        spicetify config extensions adblock.js 2>/dev/null || true
        spicetify apply 2>/dev/null || true
      fi
    '';
  };
}
