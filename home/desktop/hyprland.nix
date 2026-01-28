{
  pkgs,
  config,
  lib,
  ...
}: let
  cfgDir = "${config.xdg.configHome}/nixos/home/desktop/configs";

  configLinks = [
    "hypr"
    "wofi"
    "wlogout"
    "swaync"
    "mpv"
  ];
in {
  home.packages = with pkgs; [
    hyprpaper
    hyprpicker
    hypridle
    hyprshot
    hyprsunset
    libnotify
    swaynotificationcenter
    playerctl
    wofi
    wlogout
    wofi-emoji
  ];

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # Configs
  home.file = lib.genAttrs configLinks (name: {
    target = "${config.xdg.configHome}/${name}";
    recursive = true;
    source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink "${cfgDir}/${name}"
    );
  });

  stylix.targets.hyprlock.enable = false;
  stylix.targets.hyprland.enable = false;
  stylix.targets.hyprpaper.enable = false;
}
