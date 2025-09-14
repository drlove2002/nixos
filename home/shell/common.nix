{
  pkgs,
  ...
}:
# nix tooling
{
  home.packages = with pkgs; [
    alejandra
    deadnix
    statix
    xclip
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
