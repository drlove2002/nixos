{ inputs, pkgs, lib, ... }: {
  home.packages = with pkgs; [ nvd nix-du nix-tree nix-melt nix-output-monitor nixtract ]
  ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [ nix-btm nix-web ];
}
