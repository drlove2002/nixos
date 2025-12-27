{...}: {
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # firewall = {
    #   enable = true;
    #   allowedTCPPorts = [
    #     22
    #     80
    #     443
    #     59010
    #     59011
    #   ];
    #   allowedUDPPorts = [
    #     59010
    #     59011
    #   ];
    # };
  };
  systemd.services.network-setup.enable = false;
}
