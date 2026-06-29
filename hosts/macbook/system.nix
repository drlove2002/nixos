{
  pkgs,
  lib,
  ...
}: {
  # Unlock sudo with Touch ID instead of password
  security.pam.services.sudo_local.touchIdAuth = true;

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

    screensaver = {
      askForPasswordDelay = 10;
    };
  };

  # macOS-specific packages
  environment.systemPackages = with pkgs; [
    mas # Mac App Store CLI
  ];

  # Nix daemon settings
  nix = {
    enable = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["@admin"];
    };

    # Apple Silicon: enable both native and Rosetta-emulated Intel binaries
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

    # NixOS VM as a remote builder for cross-compiling Linux binaries
    linux-builder.enable = true;
  };

  system.primaryUser = "sudiproy";

  # Used for backwards compatibility; read the changelog before changing.
  system.stateVersion = 6;
}
