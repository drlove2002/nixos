{...}: {
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nftables.enable = true;
    # firewalld.enable = true;
    firewall = {
      enable = false;
      allowedTCPPorts = [
        5900
        5901
      ];
    };
  };
  services.firewalld.zones = {
    whonix-external.interfaces = ["Whonix-External"];
    whonix-internal.interfaces = ["Whonix-Internal"];
  };
  networking.firewall.trustedInterfaces = ["vibr0"];
  systemd.services.network-setup.enable = false;
}
