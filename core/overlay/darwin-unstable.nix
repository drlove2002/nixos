{inputs, ...}: {
  nixpkgs.overlays = [
    (
      final: prev: let
        unstablePkgs = import inputs.nixpkgs-unstable {
          system = prev.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
        # mesa/darwin.nix throws driverLink. Override at the drv level.
        driver = prev.runCommand "driverLink-stub" {} "mkdir -p $out/lib";
      in {
        unstable = unstablePkgs;
        mesa = prev.mesa.overrideAttrs (oa: {
          driverLink = driver;
          passthru = (oa.passthru or {}) // { driverLink = driver; };
        });
      }
    )
  ];
}
