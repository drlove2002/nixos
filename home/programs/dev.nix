{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gcc
    gnumake
    cmake
    pkg-config

    nixd
    alejandra
    markdownlint-cli2

    nodePackages.pnpm

    python312
    uv
    ruff
    pyright

    protobuf
    # texliveFull # TODO: huge, test separately
    lua-language-server
    marksman
    taplo
    vtsls
    yaml-language-server
    fzf
    rsync
    # google-cloud-sdk # TODO: test separately
    tokei

    ngrok
    # cmatrix # TODO: test separately
    # ddcutil # monitor control, Linux-only
  ];
}
