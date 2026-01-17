{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd
    alejandra
    nodePackages.npm
    nodePackages.pnpm
    python312
    uv
    ruff
    protobuf
  ];
}
