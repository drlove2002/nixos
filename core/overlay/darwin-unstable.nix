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

        # mesa/darwin.nix:67 sets driverLink = throw "not supported on darwin".
        # But HM's targets/darwin/fonts.nix buildsEnv from all home.packages,
        # transitively pulling libglvnd.driverLink. Override to a real path.
        mesa = prev.mesa.overrideAttrs (old: {
          passthru = (old.passthru or {}) // {
            driverLink = prev.runCommand "driverLink-stub" {} "mkdir -p $out/lib";
          };
        });
      }
    )
  ];
}
