{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = [ pkgs.nerd-fonts.iosevka ];
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka Nerd Font";
      font_size = 13;
      enable_audio_bell = false;
      shell = "zsh";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      scrollback_lines = 10000;
      scrollback_pager_history_size = 10;
      mouse_hide_wait = 3.0;
      hide_window_decorations = "no";
      notify_on_cmd_finish = "invisible 20";

      # Enable remote control for session management
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty-love";

      # Kanagawa Dragon color scheme
      background = "#181616";
      foreground = "#c5c9c5";
      selection_background = "#2D4F67";
      selection_foreground = "#C8C093";
      url_color = "#72A7BC";
      cursor = "#C8C093";
      active_tab_background = "#12120f";
      active_tab_foreground = "#C8C093";
      inactive_tab_background = "#12120f";
      inactive_tab_foreground = "#a6a69c";
      color0 = "#0d0c0c";
      color1 = "#c4746e";
      color2 = "#8a9a7b";
      color3 = "#c4b28a";
      color4 = "#8ba4b0";
      color5 = "#a292a3";
      color6 = "#8ea4a2";
      color7 = "#C8C093";
      color8 = "#a6a69c";
      color9 = "#E46876";
      color10 = "#87a987";
      color11 = "#E6C384";
      color12 = "#7FB4CA";
      color13 = "#938AA9";
      color14 = "#7AA89F";
      color15 = "#c5c9c5";
      color16 = "#b6927b";
      color17 = "#b98d7b";
    };
  };

  # Create persistent session directory
  xdg.configFile."kitty/sessions/.keep".text = "";
}
