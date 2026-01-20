{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    protobuf
    cargo-cache
    cargo-sweep
    sqlx-cli
  ];
}
