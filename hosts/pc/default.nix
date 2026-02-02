{
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote # Secure Boot support
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ./../../core
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hmbackup";
  home-manager.extraSpecialArgs = {
    inherit inputs username;
  };
  home-manager.users.love = import ./../../home;
}
