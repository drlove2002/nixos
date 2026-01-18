{pkgs, ...}: {
  home.packages = with pkgs; [
    freetube
    gimp
    obsidian
    dbeaver-bin
    gitkraken
    mpv
    qbittorrent-enhanced # bittorrent
    libreoffice-qt-fresh # Ms-Word
  ];
}
