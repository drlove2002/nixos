{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    deadnix
    statix
    wl-clipboard
    bat
    eza
    fd
    perf
    zip
    unzip
    ripgrep
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
