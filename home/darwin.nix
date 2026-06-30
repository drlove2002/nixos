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

  # Symlink .app bundles into ~/Applications (flat, no subdir)
  home.activation.linkApplications = lib.hm.dag.entryAfter ["linkGeneration"] ''
    apps_dir="${config.home.homeDirectory}/Applications"
    hm_apps="${config.home.path}/Applications"
    rm -rf "$apps_dir"
    mkdir -p "$apps_dir"
    if [ -d "$hm_apps" ]; then
      for app in "$hm_apps"/*.app; do
        [ -e "$app" ] || continue
        name="$(basename "$app")"
        ln -sfn "$app" "$apps_dir/$name"
      done
    fi
  '';
}
