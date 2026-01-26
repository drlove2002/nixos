{pkgs, ...}: {
  home.packages = with pkgs; [
    qalculate-gtk
    freetube
    gimp
    obsidian
    dbeaver-bin
    gitkraken
    mpv
    qbittorrent-enhanced # bittorrent
    libreoffice-qt-fresh # Ms-Word
    (zathura.override
      {plugins = with zathuraPkgs; [zathura_pdf_mupdf];})
  ];
}
