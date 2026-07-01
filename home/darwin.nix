{ inputs, username, lib, config, ... }: {
  disabledModules = [
  ];

  imports = [
    ./dummy-options.nix
    ./programs/shared.nix
    ./shell/shared.nix
    ./shell/aliases.nix
    ./shell/backup-darwin.nix
    ./desktop/shared.nix
    ./desktop/hammerspoon.nix
  ];

  home = {
    username = username;
    homeDirectory = lib.mkForce "/Users/${username}";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  # Write .app bundles to a hidden dir instead of ~/Applications.
  # The nix-darwin activation script links them into /Applications.
  targets.darwin.linkApps.directory = ".local/share/nix-apps";
}
