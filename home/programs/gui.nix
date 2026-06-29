{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    obsidian
    mpv
    qbittorrent-enhanced
    (zathura.override
      {plugins = with zathuraPkgs; [zathura_pdf_mupdf];})
  ] ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
    audacity
    qalculate-gtk
    gimp
    dbeaver-bin
    gitkraken
    libreoffice-qt-fresh
    kdePackages.kdenlive
    (jetbrains.plugins.addPlugins jetbrains.pycharm ["ideavim"])
    redisinsight
    unstable.stirling-pdf-desktop
  ];
