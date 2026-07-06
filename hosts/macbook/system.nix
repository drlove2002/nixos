{
  pkgs,
  lib,
  homebrew-core,
  homebrew-cask,
  homebrew-sikarugir,
  ...
}: {
  # Unlock sudo with Touch ID instead of password
  # Using pam_tid.so.2 — macOS Sequoia renamed it from pam_tid.so
  # pam-reattach makes Touch ID work inside tmux/screen sessions
  security.pam.services.sudo_local.text = ''
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
    auth       sufficient     pam_tid.so.2
  '';

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
      "FiloSottile/musl-cross"
    ];
    brews = ["musl-cross" "spicetify-cli"];
    casks = ["sikarugir" "spotify" "cloudflare-warp" "protonvpn"];
    onActivation = {
      upgrade = true;
      autoUpdate = true;
    };
  };

  nix-homebrew = let
    musl-cross-src = builtins.fetchTree {
      type = "github";
      owner = "FiloSottile";
      repo = "homebrew-musl-cross";
      rev = "705df29f2bdb4ea5e7c2ade052c92506e8c3c74a";
      narHash = "sha256-42BPsdnsz9HgSA3i+mBzMoBEegk50ZomLIW3EGuJIAk=";
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
      "FiloSottile/homebrew-musl-cross" = musl-cross-src;

    };
    mutableTaps = false;
    trust = {
      formulae = [];
      casks = [];
      commands = [];
      taps = ["Sikarugir-App/sikarugir" "FiloSottile/musl-cross"];
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

  # Symlink Home Manager .apps into /Applications
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

  # Auto-load yabai scripting addition at boot (needed for space/window commands).
  # Must run as root. Path is stable: /usr/local/bin/yabai-official.
  system.activationScripts.yabaiSA.text = ''
    if [ -f /usr/local/bin/yabai-official ]; then
      /usr/local/bin/yabai-official --load-sa || true
    fi
  '';

  # Apply new system defaults without logout/login cycle
  # Trackpad settings must be written directly — activateSettings alone doesn't
  # reliably apply them to the running session after a system activation.
  system.activationScripts.postActivation.text = ''
    # Symlink system-level .apps (must run post-switch — /run/current-system isn't updated yet during "applications")
    system_apps="/run/current-system/Applications"
    if [ -d "$system_apps" ]; then
      for app in "$system_apps"/*.app; do
        [ -d "$app" ] || continue
        name="$(basename "$app")"
        ln -sfn "$app" "/Applications/$name"
      done
    fi
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
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
