{pkgs, ...}: {
  home.packages = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    cargo-cache
    cargo-sweep
    sqlx-cli
  ];
}
