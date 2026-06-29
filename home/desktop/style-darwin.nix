{pkgs, ...}: {
  home.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
  ];

  stylix.enableReleaseChecks = false;
}
