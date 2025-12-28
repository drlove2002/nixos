{pkgs, ...}: {
  home.packages = with pkgs; [
    freetube
    gimp
    obsidian
    dbeaver-bin
    gitkraken
    spotify
    vlc
    qbittorrent-enhanced # bittorrent
    libreoffice-qt-fresh # Ms-Word
  ];
}
