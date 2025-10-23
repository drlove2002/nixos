{ ... }:

{
  # Enable flakes and the new nix command-line interface
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}