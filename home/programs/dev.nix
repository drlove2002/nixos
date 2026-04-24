{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gcc
    gdb
    gnumake
    cmake
    pkg-config

    nixd
    alejandra
    markdownlint-cli2

    nodePackages.npm
    nodePackages.pnpm

    python312
    uv
    ruff
    pyright

    protobuf
    texliveFull
    texpresso
    lua-language-server
    marksman
    neocmakelsp
    taplo
    vtsls
    yaml-language-server
    fzf
    rsync
    google-cloud-sdk

    ngrok
  ];
}
