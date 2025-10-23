# This module defines an overlay to add packages from nixpkgs-unstable.
{ inputs, ... }:

{
  nixpkgs.overlays = [
    (final: prev:
      let
        unstable-pkgs = import inputs.nixpkgs-unstable {
          system = prev.system;
          config = {
            allowUnfree = true;
          };
          # Config is inherited from the top-level nixpkgs configuration
        };
      in
      {
        unstable = unstable-pkgs; # Provides pkgs.unstable for convenience
        # ollama = unstable-pkgs.ollama; # Overlays ollama from unstable for the service

        # Overlay Plasma and related packages from unstable for the latest version.
        # kdePackages = unstable-pkgs.kdePackages;
        # sddm = unstable-pkgs.sddm;
      })
  ];
}
