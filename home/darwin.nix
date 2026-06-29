{ inputs, username, lib, config, ... }: {
  # HM's darwin targets (fonts, linkapps, copyapps) all evaluate
  # config.home.packages which transitively pulls mesa.driverLink
  # that throws on darwin. Disable them all — not needed on macOS.
  disabledModules = [
    "targets/darwin/fonts.nix"
    "targets/darwin/linkapps.nix"
    "targets/darwin/copyapps.nix"
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
