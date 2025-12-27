{...}: {
  # home.packages = with pkgs; [
  #   qt6.full
  # ];  TODO: In future when I build quickshell app I'll need this
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
