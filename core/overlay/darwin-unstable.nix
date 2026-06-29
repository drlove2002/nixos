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

        # mesa/darwin.nix:67 sets driverLink = throw "driverLink not
        # supported on darwin". HM's targets/darwin/* modules evaluate
        # all home.packages transitively, tripping this throw. Override
        # the passthru to return null instead.
        mesa = prev.mesa.overrideAttrs (old: {
          passthru = (old.passthru or {}) // {
            driverLink = null;
          };
        });
      }
    )
  ];
}
