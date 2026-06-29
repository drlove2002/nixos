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
        # HM's targets/darwin/fonts.nix buildEnv scans all home.packages,
        # transitively pulling mesa, which throws. Override to a dummy package.
        mesa = let
          dummy = prev.runCommand "driverLink-stub" {} "mkdir -p $out/lib";
        in prev.mesa.overrideAttrs (old: {
          passthru = (old.passthru or {}) // { inherit dummy driverLink; };
          driverLink = dummy;
        });
      }
    )
  ];
}
