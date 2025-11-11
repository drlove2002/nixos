{
  pkgs,
  inputs,
  system,
  ...
}:
{
  home.packages = with pkgs; [
    zip
    unzip
    ripgrep
    nixfmt-rfc-style
    obsidian
    inputs.zen-browser.packages."${system}".default
    dbeaver-bin
    gitkraken
    spotify
    vlc

    # Programming languages and tools
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    python312
    python312Packages.pip
    python312Packages.virtualenv
  ];

  programs = {

    vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
    };

    btop.enable = true; # replacement of htop/nmon
    ssh.enable = true;
    aria2.enable = true;

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

  services = {
    # auto mount usb drives
    udiskie.enable = true;
  };
}
