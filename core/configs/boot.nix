{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
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
    # Keep the known-good 6.19.9 kernel from generation 425.
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linuxKernel.kernels.linux_6_19.override {
      argsOverride = rec {
        version = "6.19.9";
        modDirVersion = "6.19.9";
        src = pkgs.fetchurl {
          url = "mirror://kernel/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
          hash = "sha256-wWBoo68S45Q97jse71fKcCKcBpEov6EYT7P0iyGdVb8=";
        };
      };
    });
  };
}
