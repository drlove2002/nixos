{ ... }:
{

  fileSystems."/run/media/love/SHARED" = {
    device = "/dev/disk/by-uuid/1039142B1039142B";
    fsType = "ntfs3"; # Modern NTFS driver (or "ntfs-3g" for older systems)
    options = [
      "rw"
      "user"
      "noauto"
      "x-systemd.automount"
    ];
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];
}
