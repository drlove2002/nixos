{pkgs, ...}: {
  # Configure service but don't auto-start it
  services.stirling-pdf = {
    enable = true;
    package = pkgs.unstable.stirling-pdf;
    environment = {
      SERVER_PORT = 38273; # Non-standard port
      SECURITY_ENABLELOGIN = "true";
    };
  };

  # Prevent auto-start on boot
  systemd.services.stirling-pdf = {
    wantedBy = pkgs.lib.mkForce [];
  };

  # Open firewall for local access
  networking.firewall.allowedTCPPorts = [38273];
}
