{
  pkgs,
  config,
  ...
}: {
  services = {
    # Core system services
    gvfs.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    udisks2.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      settings = {
        Theme = {
          Current = "sddm-astronaut-theme";
          CursorTheme = config.stylix.cursor.name;
          CursorSize = config.stylix.cursor.size;
        };
      };
      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtvirtualkeyboard
        kdePackages.qtmultimedia
      ];
    };
    displayManager.defaultSession = "hyprland";
    # Power / logind behavior
    logind.settings = {
      Login = {
        HandlePowerKey = "suspend-then-hibernate";
        HandlePowerKeyLongPress = "poweroff";
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        KillUserProcesses = false;
        HibernateDelaySec = 3600;
        InhibitorsMax = 8192;
        PowerKeyIgnoreInhibited = true;
        SuspendKeyIgnoreInhibited = true;
        HibernateKeyIgnoreInhibited = true;
        LidSwitchIgnoreInhibited = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {embeddedTheme = "hyprland_kath";})
  ];
  systemd.sleep.extraConfig = ''
    [Sleep]
    SuspendState=mem
    HibernateDelaySec=3600
    HibernateMode=shutdown
  '';

  powerManagement.enable = true;
}
