{ username, ... }: {
  imports = [
    ./dummy-options.nix
    ./programs
    ./shell
    ./desktop
  ];

  # Home Manager
  home = {
    username = username;
    homeDirectory = "/home/love";

    stateVersion = "25.05"; # DO NOT CHANGE
  };

  targets.genericLinux.nixGL.vulkan.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
