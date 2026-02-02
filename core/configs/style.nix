{
  pkgs,
  config,
  ...
}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    enable = true;
    autoEnable = true;

    override = {
      base05 = "EEE6C9";
      base0D = "98BBF5";
    };

    image = ../../assets/wallpaper.jpg;
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    icons = {
      enable = true;
      dark = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    # No need for opacity
    # opacity = {
    #   applications = 0.8;
    #   desktop = 0.8;
    #   popups = 1;
    #   terminal = 0.8;
    # };
    #
    fonts = {
      sizes = {
        applications = 12;
        terminal = 16;
        desktop = 12;
      };

      monospace = {
        package = pkgs.maple-mono-custom;
        name = "Maple Mono";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };

      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
    };
    enableReleaseChecks = false;
    polarity = "dark";
  };
}
