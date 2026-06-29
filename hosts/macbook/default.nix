{
  inputs,
  username,
  ...
}: {
  imports = [
    ./system.nix
    ./../../core/overlay/darwin-unstable.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hmbackup";
  home-manager.extraSpecialArgs = {
    inherit inputs username;
  };
  home-manager.users.${username} = import ./../../home/darwin.nix;
}
