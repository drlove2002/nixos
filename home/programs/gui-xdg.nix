{pkgs, config, ...}: {
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

  xdg.desktopEntries = {
    "io.github.Stirling-Tools.Stirling-PDF" = {
      name = "Stirling PDF (hidden)";
      noDisplay = true;
    };
    "Stirling-PDF" = {
      name = "Stirling PDF (hidden)";
      noDisplay = true;
    };
    "stirling-pdf-launcher" = {
      name = "Stirling PDF";
      genericName = "PDF Editor";
      comment = "Powerful PDF manipulation tool with auto-configured local server";
      exec = "${config.home.homeDirectory}/.local/bin/stirling-pdf-launcher";
      icon = "stirling-pdf";
      terminal = false;
      categories = ["Office" "Utility"];
    };
  };

  xdg.configFile."Stirling-PDF/connection.json".text = builtins.toJSON {
    setup_completed = true;
    connection_mode = "self-hosted";
    server_url = "http://localhost:38273";
    lock_connection_mode = false;
    login_mode = true;
  };
}
