{
  inputs,
  username,
  ...
}: {
  imports = [
    ./system.nix
    ./db.nix
    ./../../core/overlay/darwin-unstable.nix
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    allowBroken = true;
  };

  users.users.sudiproy = {
    name = "sudiproy";
    home = "/Users/sudiproy";
    uid = 501;
  };

  users.knownUsers = [ "sudiproy" ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hmbackup";
  home-manager.extraSpecialArgs = {
    inherit inputs username;
  };
  home-manager.users.${username} = import ./../../home/darwin.nix;
}
