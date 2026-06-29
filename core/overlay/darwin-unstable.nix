# Minimal overlay: provides pkgs.unstable for shared HM modules (zed, vscodium)
{inputs, ...}: {
  nixpkgs.overlays = [
    (
      final: prev: let
        unstablePkgs = import inputs.nixpkgs-unstable {
          system = prev.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
      in {
        unstable = unstablePkgs;
      }
    )
  ];
}
