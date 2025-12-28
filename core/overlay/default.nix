# This module defines an overlay to add packages from nixpkgs-unstable.
{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    inputs.nur.overlays.default
    (
      final: prev: let
        unstable-pkgs = import inputs.nixpkgs-unstable {
          system = prev.pkgs.stdenv.hostPlatform.system;
          config = {
            allowUnfree = true;
          };
          # Config is inherited from the top-level nixpkgs configuration
        };
      in {
        unstable = unstable-pkgs; # Provides pkgs.unstable for convenience

        maple-mono-custom = final.callPackage ./maple-mono.nix {};
      }
    )
  ];
}
