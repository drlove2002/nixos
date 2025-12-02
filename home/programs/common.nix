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
    inputs.antigravity-nix.packages."${system}".default
    dbeaver-bin
    gitkraken
    spotify
    vlc

    # Programming languages and tools
    nodePackages.npm
    nodePackages.pnpm
    python312
    python312Packages.pip
    python312Packages.virtualenv
    uv
  ];

  programs = {
    vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
    };

    btop.enable = true;
    ssh = {
      enable = true;
      enableDefaultConfig = false;
    };
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
