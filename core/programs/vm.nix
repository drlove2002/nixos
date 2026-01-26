{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qemu
    virt-viewer
  ];

  # Virt-Manager GUI
  programs.virt-manager.enable = true;
  virtualisation = {
    # libvirtd daemon
    libvirtd = {
      enable = true;
      firewallBackend = "nftables";
      qemu = {
        package = pkgs.qemu_kvm;
        # enables a TPM emulator
        swtpm.enable = true;
      };
    };
    # allow USB device to be forwarded
    spiceUSBRedirection.enable = true;
  };
  # Spice protocol improves VM display and input responsiveness
  services.spice-vdagentd.enable = true;
}
