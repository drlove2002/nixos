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

  # Symlink Home Manager .apps into /Applications so Launchpad/Finder index them
  system.activationScripts.applications.text = ''
    apps_dir="/Applications/Nix Apps"
    hm_apps="/Users/sudiproy/.nix-profile/Applications"
    rm -rf "$apps_dir"
    mkdir -p "$apps_dir"
    if [ -d "$hm_apps" ]; then
      for app in "$hm_apps"/*.app; do
        [ -d "$app" ] || continue
        name="$(basename "$app")"
        ln -sfn "$app" "$apps_dir/$name"
      done
    fi
    # Also link into ~/Applications so open -a works
    user_dir="/Users/sudiproy/Applications"
    rm -rf "$user_dir"
    mkdir -p "$user_dir"
    if [ -d "$hm_apps" ]; then
      for app in "$hm_apps"/*.app; do
        [ -d "$app" ] || continue
        name="$(basename "$app")"
        ln -sfn "$app" "$user_dir/$name"
      done
    fi
    chown -R sudiproy "$apps_dir" "$user_dir" 2>/dev/null || true
  '';

  # Apply new system defaults without logout/login cycle
  system.activationScripts.postActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
