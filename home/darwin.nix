{ inputs, username, lib, config, ... }: {
  disabledModules = [
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

  # Link .app bundles into ~/Applications (macOS Launchpad reads this)
  home.activation.linkApps = {
    after = ["linkGeneration"];
    before = [];
    data = ''
      apps_dir="$HOME/Applications"
      hm_apps="${config.home.path}/Applications"
      rm -rf "$apps_dir"
      mkdir -p "$apps_dir"
      if [ -d "$hm_apps" ]; then
        for app_dir in "$hm_apps"/*.app; do
          [ -d "$app_dir" ] || continue
          name="$(basename "$app_dir")"
          ln -sfn "$app_dir" "$apps_dir/$name"
        done
      fi
    '';
  };
}
