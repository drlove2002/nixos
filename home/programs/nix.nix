{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
    nix-index = {
      enable = true;
      enableZshIntegration = false;
    };
  };

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  home.packages = with pkgs; [
    nvd
    nix-du
    nix-tree
    nix-melt
    nix-output-monitor
    nixtract
  ] ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
    nix-btm # needs perf-linux → elfutils → __thread (darwin: no)
    nix-web # TODO: test on darwin separately
    nix-index # TODO: test on darwin separately
  ];
}
