{
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.nix-darwin.darwinModules.nix-darwin
    inputs.home-manager.darwinModules.home-manager
    inputs.stylix.darwinModules.stylix
    ./system.nix
  ];

  # Stylix on darwin — auto-enable the darwin module, disable linux-only targets
  stylix = {
    autoEnable = true;
    targets = {
      hyprlock.enable = false;
      hyprland.enable = false;
      hyprpaper.enable = false;
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hmbackup";
  home-manager.extraSpecialArgs = {
    inherit inputs username;
  };
  home-manager.users.${username} = import ./../../home/darwin.nix;
}
