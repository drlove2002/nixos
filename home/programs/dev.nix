{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    gdb
    gnumake
    cmake
    pkg-config

    nixd
    alejandra

    nodePackages.npm
    nodePackages.pnpm

    python312
    uv
    ruff

    protobuf
    texliveFull
  ];
}
