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

        # mesa/darwin.nix throws on darwin. Override to provide a stub.
        mesa = (prev.mesa.override {
          enablePatentEncumberedCodecs = false;
        }).overrideAttrs (old: {
          passthru = (old.passthru or {}) // {
            driverLink = null;
          };
        });
      }
    )
  ];
}
