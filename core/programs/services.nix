{ pkgs, ... }:
{
  services = {
    gvfs.enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome = {
      tinysparql.enable = true;
      gnome-keyring.enable = true;
    };

    dbus.enable = true;
    fstrim.enable = true;

    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandlePowerKey = "suspend-then-hibernate";
      KillUserProcesses = false;
    };

    udisks2.enable = true;
  };
}
