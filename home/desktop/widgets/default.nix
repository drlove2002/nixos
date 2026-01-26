{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [];
  home.packages = with pkgs; [
    eww
  ];

  home.file."${config.xdg.configHome}/eww" = {
    recursive = true;
    source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos/home/desktop/widgets/eww");
  };
}
