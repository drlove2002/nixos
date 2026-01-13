{pkgs, ...}: {
  services = {
    gvfs.enable = true;

    # Enable Gnome and GDM
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome = {
      tinysparql.enable = true;
      gnome-keyring.enable = true;
      core-apps.enable = false;
      core-developer-tools.enable = false;
      games.enable = false;
    };

    dbus.enable = true;
    fstrim.enable = true;

    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    logind.settings = {
      Login = {
        HandlePowerKey = "suspend-then-hibernate";
        HandlePowerKeyLongPress = "poweroff"; # Long press = shutdown
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        KillUserProcesses = false;
        HibernateDelaySec = 3600; # 1 hour
        InhibitorsMax = 8192;
        PowerKeyIgnoreInhibited = true;
        SuspendKeyIgnoreInhibited = true;
        HibernateKeyIgnoreInhibited = true;
        LidSwitchIgnoreInhibited = true;
      };
    };

    udisks2.enable = true;
  };
  systemd.sleep.extraConfig = ''
    [Sleep]
    SuspendState=mem
    HibernateDelaySec=3600
    HibernateMode=shutdown
  '';
  powerManagement.enable = true;
}
