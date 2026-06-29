{pkgs, ...}: {
  home.packages = with pkgs; [
    audacity
    qalculate-gtk
    gimp
    obsidian
    dbeaver-bin
    gitkraken
    mpv
    qbittorrent-enhanced
    libreoffice-qt-fresh
    (zathura.override
      {plugins = with zathuraPkgs; [zathura_pdf_mupdf];})
    kdePackages.kdenlive
    (jetbrains.plugins.addPlugins jetbrains.pycharm ["ideavim"])
    redisinsight
    unstable.stirling-pdf-desktop
  ];
}
