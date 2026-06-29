{
  pkgs,
  lib,
  ...
}: {
  # macOS system defaults managed by nix-darwin
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      orientation = "bottom";
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXPreferredViewStyle = "Nlsv"; # list view
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      "com.apple.swipescrolldirection" = true;
    };
  };

  # macOS-specific packages
  environment.systemPackages = with pkgs; [
    mas # Mac App Store CLI
  ];

  # Nix daemon settings
  nix = {
    enable = false; # nix-darwin manages nix differently
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["@admin"];
    };
  };

  # Used for backwards compatibility; read the changelog before changing.
  system.stateVersion = 6;
}
