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
    homeDirectory = lib.mkForce "/Users/${username}";
    stateVersion = "25.05";
  };

  # HM's darwin target modules (fonts.nix, linkapps.nix, etc.) all
  # evaluate config.home.packages which transitively pulls mesa.driverLink
  # that throws on darwin. We don't need these on macOS — set to empty.
  targets.darwin = lib.mkForce {};

  programs.home-manager.enable = true;
}
