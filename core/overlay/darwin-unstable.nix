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

        # mesa/darwin.nix:67 sets driverLink = throw "not supported".
        # HM's darwin targets scan all home.packages transitively.
        # Override the passthru via the final overlay to return null.
        mesa = prev.mesa.overrideAttrs (old: {
          passthru = (old.passthru or {}) // {
            driverLink = null;
          };
        });
      }
    )
  ];
}
