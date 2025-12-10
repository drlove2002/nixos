{
  pkgs,
  inputs,
  system,
  ...
}:
{
  home.packages = with pkgs; [
    perf
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
    nodePackages.npm
    nodePackages.pnpm
    python312
    python312Packages.pip
    python312Packages.virtualenv
    uv
  ];

  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
    };
    aria2.enable = true;
  };

  services = {
    # auto mount usb drives
    udiskie.enable = true;
  };
}
