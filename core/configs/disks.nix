{...}: {
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/48616cf5-7cca-47c2-b73b-f24ff2fd42a4";
    fsType = "ext4";
    options = ["defaults" "nofail"];
  };
  systemd.tmpfiles.rules = [
    "d /data 0775 love users - -"
  ];
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];
}
