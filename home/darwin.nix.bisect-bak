{ inputs, username, lib, config, ... }: {
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
