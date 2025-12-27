{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
  ];

  # home.packages = with pkgs; [
  #   qt6.full
  # ];  TODO: In future when I build quickshell app I'll need this
  stylix.targets.qt.platform = "qtct";
  stylix.enableReleaseChecks = false;
  qt = {
    enable = true;
  };
}
