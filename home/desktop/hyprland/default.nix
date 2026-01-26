{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    hyprpaper
    hyprpicker
    hypridle
    hyprshot
    wofi
    hyprland
    wlogout
    wofi-emoji
  ];
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  home.file."${config.xdg.configHome}/hypr" = {
    recursive = true;
    source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos/home/desktop/hyprland/config");
  };

  home.file."${config.xdg.configHome}/wofi" = {
    recursive = true;
    source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos/home/desktop/widgets/wofi");
  };

  home.file."${config.xdg.configHome}/wlogout" = {
    recursive = true;
    source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos/home/desktop/widgets/wlogout");
  };
  stylix.targets.hyprlock.enable = false;
  stylix.targets.hyprland.enable = false;
  stylix.targets.hyprpaper.enable = false;
}
