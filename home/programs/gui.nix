{pkgs, ...}: {
  home.packages = with pkgs; [
    qalculate-gtk
    gimp
    obsidian
    dbeaver-bin
    gitkraken
    mpv
    qbittorrent-enhanced # bittorrent
    libreoffice-qt-fresh # Ms-Word
    (zathura.override
      {plugins = with zathuraPkgs; [zathura_pdf_mupdf];})
    kdePackages.kdenlive
    (jetbrains.plugins.addPlugins jetbrains.pycharm ["ideavim"])
    redisinsight
    unstable.stirling-pdf-desktop
  ];

  # Force DBeaver to use the default GTK theme instead of Stylix.
  xdg.desktopEntries.dbeaver = {
    name = "dbeaver-ce";
    genericName = "Universal Database Manager";
    comment = "Universal Database Manager and SQL Client.";
    exec = "env GTK_THEME=Adwaita NO_AT_BRIDGE=1 ${pkgs.dbeaver-bin}/bin/dbeaver %U";
    icon = "dbeaver";
    terminal = false;
    categories = ["IDE" "Development"];
    settings.StartupWMClass = "DBeaver";
    startupNotify = true;
    mimeType = ["application/sql"];
  };

  # Hide the package's default desktop entries and create our custom launcher
  xdg.desktopEntries = {
    # Hide both original desktop entries from the package
    "io.github.Stirling-Tools.Stirling-PDF" = {
      name = "Stirling PDF (hidden)";
      noDisplay = true;
    };

    "Stirling-PDF" = {
      name = "Stirling PDF (hidden)";
      noDisplay = true;
    };

    # Create custom launcher that uses our wrapper script
    "stirling-pdf-launcher" = {
      name = "Stirling PDF";
      genericName = "PDF Editor";
      comment = "Powerful PDF manipulation tool with auto-configured local server";
      exec = "/home/love/.local/bin/stirling-pdf-launcher"; # Full path to bash wrapper
      icon = "stirling-pdf";
      terminal = false;
      categories = ["Office" "Utility"];
    };
  };

  # Pre-configure Stirling PDF desktop with server URL
  xdg.configFile."Stirling-PDF/connection.json".text = builtins.toJSON {
    setup_completed = true;
    connection_mode = "self-hosted";
    server_url = "http://localhost:38273";
    lock_connection_mode = false;
    login_mode = true;
  };
}
