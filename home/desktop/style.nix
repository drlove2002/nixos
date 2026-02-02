{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
  ];

  stylix.targets.qt.platform = "qtct";
  stylix.enableReleaseChecks = false;
  qt = {
    enable = true;
  };
}
