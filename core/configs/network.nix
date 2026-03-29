{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [tailscale];
  services.tailscale.enable = true;
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nftables.enable = true;
    # firewalld.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        5900
        5901
      ];
      allowedUDPPorts = [config.services.tailscale.port];
      trustedInterfaces = ["vibr0" "tailscale0"];
    };
  };
  services.firewalld.zones = {
    whonix-external.interfaces = ["Whonix-External"];
    whonix-internal.interfaces = ["Whonix-Internal"];
  };
  systemd.services.network-setup.enable = false;

  # Tailscale
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
  services.tailscale.useRoutingFeatures = "client";
}
