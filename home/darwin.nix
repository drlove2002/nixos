{ username, ... }: {
  imports = [
    ./dummy-options.nix
    ./programs
    ./shell/shared.nix
    ./shell/aliases.nix
    ./desktop/shared.nix
    ./darwin/launchd.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}"; # macOS prefix

    stateVersion = "25.05"; # DO NOT CHANGE
  };

  # No nixGL on macOS — OpenGL/Metal is native.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
