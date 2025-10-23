{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
        vesktop
  ];

  # make vesktop autostart properly
  xdg.configFile."autostart/vesktop.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Version=1.0
    Name=Vencord
    Comment=Vencord autostart script
    Exec=sh -c "${pkgs.vesktop} --start-minimized --ozone-platform=wayland"
    Terminal=false
    StartupNotify=false
  '';
}