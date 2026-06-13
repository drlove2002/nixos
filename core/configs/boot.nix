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

    # Pin to exactly 7.0.11 (prevents surprise bumps on flake update)
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linuxKernel.kernels.linux_7_0.override {
      argsOverride = rec {
        version = "7.0.11";
        modDirVersion = "7.0.11";
        src = pkgs.fetchurl {
          url = "mirror://kernel/linux/kernel/v7.x/linux-7.0.11.tar.xz";
          hash = "sha256-5WyDVt2gETamBBxu+DK9Dsmb0tNd/5eDKqXsEO0BQwQ=";
        };
      };
    });
  };

  # Allow user access to i2c devices for DDC/CI monitor brightness
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", MODE="0666"
  '';

  # OpenRGB udev rules for keyboard/motherboard RGB control
  services.udev.packages = [ pkgs.openrgb ];
}
