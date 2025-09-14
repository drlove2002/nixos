{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
}
