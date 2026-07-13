{
  pkgs,
  lib,
  ...
}: {
  home.packages =
    (with pkgs; [
      gnumake
      cmake
      nixd
      nil
      alejandra
      markdownlint-cli2

      ruff
      pyright

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
    ])
    ++ lib.optionals pkgs.stdenv.isLinux (with pkgs; [
      gcc
    ]);
}
