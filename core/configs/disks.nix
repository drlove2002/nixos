{...}: {
  fileSystems."/run/media/love/SHARED" = {
    device = "/dev/disk/by-uuid/1039142B1039142B";
    fsType = "ntfs3"; # Modern NTFS driver (or "ntfs-3g" for older systems)
    options = [
      "defaults"
      "nofail"
      "force" # If dirty flag persists post-chkdsk
      "uid=1000" # Your user ID (run `id -u`)
      "gid=100" # Your GID or shared group
      "umask=0000" # Defaults
    ];
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];
}
