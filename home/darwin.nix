{ inputs, username, lib, ... }: {
  imports = [
    ./dummy-options.nix
    ./programs/shared.nix
    ./shell/shared.nix
    ./shell/aliases.nix
    ./desktop/shared.nix
  ];

  home = {
    username = username;
    homeDirectory = lib.mkForce "/Users/${username}"; # macOS prefix

    stateVersion = "25.05"; # DO NOT CHANGE
  };

  # No nixGL on macOS — OpenGL/Metal is native.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
