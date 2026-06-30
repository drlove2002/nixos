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
      FXPreferredViewStyle = "Nlsv";
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

  environment.systemPackages = with pkgs; [
    mas
  ];

  nix = {
    enable = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["@admin"];
    };
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
    linux-builder.enable = true;
  };

  system.primaryUser = "sudiproy";
  system.stateVersion = 6;

  # Apply new system defaults without logout/login cycle
  system.activationScripts.postActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
