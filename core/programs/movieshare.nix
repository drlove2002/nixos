{
  pkgs,
  lib,
  ...
}: {
  # Samba server configuration (guest browseable)
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        workgroup = "WORKGROUP";
        "map to guest" = "Bad User";
      };

      movies = {
        path = "/data/Videos/Movies";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "force user" = "love";
      };
    };
  };
  # Avahi for discovery on LAN (helps Android find the share)
  services.avahi = {
    enable = true;
    openFirewall = true;
  };

  # Prevent automatic start at boot; we will toggle with movieshare on/off
  systemd.services."samba-smbd".wantedBy = lib.mkForce [];
  systemd.services."samba-nmbd".wantedBy = lib.mkForce [];
  systemd.services."samba-winbindd".enable = false;

  # movieshare toggle helper
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "movieshare" ''
      case "$1" in
        on)
          sudo systemctl start avahi-daemon samba-smbd samba-nmbd
          systemd-inhibit --what=sleep --why="Streaming movies" sleep infinity &
          echo $! > /tmp/movieshare.lock
          echo "Movieshare ON (sleep disabled)"
          ;;
        off)
          sudo systemctl stop samba-smbd samba-nmbd
          if [ -f /tmp/movieshare.lock ]; then
            kill $(cat /tmp/movieshare.lock)
            rm /tmp/movieshare.lock
          fi
          echo "Movieshare OFF (sleep allowed)"
          ;;
        *)
          echo "Usage: movieshare on|off"
          ;;
      esac
    '')
  ];
}
