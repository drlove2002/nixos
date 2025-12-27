{pkgs, ...}: {
  services.xserver.videoDrivers = ["modesetting"];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };
  hardware.enableRedistributableFirmware = true;
  boot.kernelParams = ["i915.force_probe=4680"];
}
