{...}: {
  imports = [
    ./disks.nix
    ./boot.nix
    ./system.nix
    ./network.nix
    ./gpu.nix
    ./audio.nix
    ./security.nix
    ./user.nix
    ./style.nix
  ];
}
