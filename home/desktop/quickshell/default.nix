{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = [
    inputs.quickshell.packages.${system}.default
    pkgs.qt6.qtwayland
  ];
  home.file."${config.xdg.configHome}/quickshell" = {
    recursive = true;
    source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink
      "${config.xdg.configHome}/nixos/home/desktop/quickshell/configs"
    );
  };
}
