{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
  };
}
