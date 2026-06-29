{ inputs, username, lib, config, ... }: {
  # HM's darwin target modules evaluate config.home.packages to do
  # font syncing, app linking, and app copying. This transitively
  # pulls in mesa.driverLink which throws on darwin. Disable them.
  disabledModules = [
    "targets/darwin/copyapps.nix"
    "targets/darwin/fonts.nix"
    "targets/darwin/keybindings.nix"
    "targets/darwin/linkapps.nix"
    "targets/darwin/search.nix"
  ];

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

  programs.home-manager.enable = true;
}
