{ pkgs, lib, ... }: {
  home.packages =
    with pkgs;
    [
      obsidian
      mpv
      qbittorrent-enhanced
    ]
    ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
      audacity
      gimp
      libreoffice-qt-fresh
      kdePackages.kdenlive
      redisinsight
      unstable.stirling-pdf-desktop
      dbeaver-bin
      (zathura.override { plugins = with zathuraPkgs; [ zathura_pdf_mupdf ]; })
    ];
}
