{
  pkgs,
  lib,
  homebrew-core,
  homebrew-cask,
  homebrew-sikarugir,
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

  homebrew = {
    enable = true;
    taps = [
      "homebrew/homebrew-core"
      "homebrew/homebrew-cask"
      "Sikarugir-App/sikarugir"
      "SergioBenitez/osxct"
    ];
    brews = ["sergiobenitez/osxct/x86_64-unknown-linux-gnu" "spicetify-cli"];
    casks = ["sikarugir" "spotify"];
    onActivation = {
      upgrade = true;
      autoUpdate = true;
    };
  };

  nix-homebrew = let
    osxct-src = builtins.fetchTree {
      type = "github";
      owner = "SergioBenitez";
      repo = "homebrew-osxct";
      rev = "22ab1343a2ec890d2c1b641061da73ff6f719841";
      narHash = "sha256-jRl18BWvwq8X00kLld4JTepGeZabAnU8hwM4GExZvG4=";
    };
  in {
    enable = true;
    enableRosetta = true;
    user = "sudiproy";
    autoMigrate = true;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "Sikarugir-App/homebrew-sikarugir" = homebrew-sikarugir;
      "SergioBenitez/homebrew-osxct" = osxct-src;
    };
    mutableTaps = false;
    trust = {
      formulae = [];
      casks = [];
      commands = [];
      taps = ["Sikarugir-App/sikarugir" "SergioBenitez/osxct"];
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

  # Symlink Home Manager .apps directly into /Applications
  system.activationScripts.applications.text = ''
    hm_apps="/Users/sudiproy/.local/share/nix-apps"
    if [ -d "$hm_apps" ]; then
      for app in "$hm_apps"/*.app; do
        [ -d "$app" ] || continue
        name="$(basename "$app")"
        ln -sfn "$app" "/Applications/$name"
      done
    fi
    # Clean up old paths that are no longer used
    rm -rf "/Applications/Nix Apps" /Users/sudiproy/Applications
  '';

  # Apply new system defaults without logout/login cycle
  # Trackpad settings must be written directly — activateSettings alone doesn't
  # reliably apply them to the running session after a system activation.
  system.activationScripts.postActivation.text = ''
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
    defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -int 1
    defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
