{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixcord.url = "github:kaylorben/nixcord";

    themes = {
      url = "github:RGBCube/ThemeNix";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      themes,
      ...
    }:
    let
      kanagawa = themes.kanagawa;
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs kanagawa; };
        modules = [
          ./hosts/pc
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hmbackup";
            home-manager.extraSpecialArgs = {
              inherit inputs kanagawa;
            };
            home-manager.users.love = import ./home;
          }
        ];
      };

    };

}
