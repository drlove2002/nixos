{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    papirus-icon-theme
    twitter-color-emoji
    material-symbols
    nerd-fonts.iosevka
  ];
  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
