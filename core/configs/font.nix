{pkgs, ...}: {
  fonts.packages = with pkgs; [
    twitter-color-emoji
    material-symbols
  ];
  fonts.fontconfig = {
    defaultFonts = {
      emoji = ["Twitter Color Emoji"];
    };
  };
}
