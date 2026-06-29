{
  inputs,
  username,
  ...
}: {
  imports = [
    ./system.nix
    ./../../core/overlay/darwin-unstable.nix
  ];

  # HM's darwin fonts module evaluates all home.packages to find fonts,
  # transitively pulling mesa.driverLink which throws on darwin.
  disabledModules = [ "targets/darwin/fonts.nix" ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hmbackup";
  home-manager.extraSpecialArgs = {
    inherit inputs username;
  };
  home-manager.users.${username} = import ./../../home/darwin.nix;
}
