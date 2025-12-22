{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    perf
    zip
    unzip
    ripgrep
    nixfmt-rfc-style
    obsidian
    dbeaver-bin
    gitkraken
    spotify
    vlc
    qbittorrent-enhanced # bittorrent
    libreoffice-qt-fresh # Ms-Word

    # Programming languages and tools
    nodePackages.npm
    nodePackages.pnpm
    python312
    uv
  ];

  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
    };
    aria2.enable = true;
  };

  services = {
    # auto mount usb drives
    udiskie.enable = true;
  };
}
