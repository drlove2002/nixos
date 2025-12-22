{ pkgs, kanagawa, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "kanagawa";
    };
    themes.kanagawa.src = pkgs.writeText "kanagawa.tmTheme" kanagawa.tmTheme;
    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
    ];
  };
}
