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

        # mesa/darwin.nix throws "driverLink not supported on darwin"
        # because driverLink is meaningless on macOS. Override mesa
        # to provide a stub so HM's darwin targets don't crash.
        mesa = prev.mesa.overrideAttrs (old: {
          driverLink = null;
        });
      }
    )
  ];
}
