{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    winetricks
    wineWowPackages.waylandFull
    samba
    (bottles.override
      {removeWarningPopup = true;})
  ];
  home.sessionVariables = {
    # prevent wine from creating file associations/desktopshotcuts
    WINEDLLOVERRIDES = "winemenubuilder.exe=d";
    WINEPREFIX = "${config.home.homeDirectory}/.local/share/wine";
  };
}
