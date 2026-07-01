{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    alejandra
    deadnix
    statix
    bat
    eza
    fd
    ffmpeg
    zip
    unzip
    ripgrep
    gum # For shell scripts TUI styling
    zstd
    gnutar
  ] ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
    wl-clipboard
    perf
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
  };
}
