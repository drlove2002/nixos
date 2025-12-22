{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    nodePackages.npm
    nodePackages.pnpm
    python312
    uv
  ];
}
