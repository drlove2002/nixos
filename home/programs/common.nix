{
  pkgs,
  inputs,
  system,
  ...
}: {
  home.packages = with pkgs; [
    zip
    unzip
    ripgrep
    obsidian
    syncthing
    inputs.zen-browser.packages."${system}".default
    nodejs
    nodePackages.npm
    nodePackages.pnpm
    python313
    python313Packages.pip
    python313Packages.virtualenv
    dbeaver-bin
    gitkraken
    unstable.ncspot
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
    syncthing.enable = true;

    # auto mount usb drives
    udiskie.enable = true;
  };
}
