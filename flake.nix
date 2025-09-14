{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    rust-overlay.url = "github:oxalica/rust-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    rust-overlay,
    home-manager,
    ...
  }: {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/pc

	({ pkgs, ... }: {
	    nixpkgs.overlays = [ rust-overlay.overlays.default ];
	})
	
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "HMBackup";
	  home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
	  home-manager.users.love = import ./home;
	}
      ];
    };

  };
  
}
