{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
    pkgs.openrgb

  ];
  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = lib.mkForce true;
      systemd-boot.configurationLimit = 10;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        # Automatically reboot to enroll the keys in the firmware
        autoReboot = true;
      };
    };
    initrd.systemd.enable = true;

    # DDC/CI monitor brightness control
    kernelModules = [ "i2c-dev" ];

    # Keep the known-good 6.19.9 kernel from generation 425.
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Allow user access to i2c devices for DDC/CI monitor brightness
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", MODE="0666"
  '';

  # OpenRGB udev rules for keyboard/motherboard RGB control
  services.udev.packages = [ pkgs.openrgb ];
}
