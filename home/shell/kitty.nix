{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.nerd-fonts.iosevka
  ];

  programs.kitty = {
    enable = true;

    settings = {
      font_family = "Iosevka Nerd Font Mono";
      font_size = 17;

      shell = "zsh";

      enable_audio_bell = false;

      extended_keyboard = "yes";

      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";

      scrollback_lines = 10000;
      scrollback_pager_history_size = 10;

      mouse_hide_wait = 3.0;

      hide_window_decorations = "no";

      notify_on_cmd_finish = "invisible 20";

      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty-love";

      # Kanagawa Dragon
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

    keybindings = {

      # Shift+Enter as CSI-u (for tmux compatibility)
      "shift+enter" = "send_text all \\x1b[13;2u";

      # Move tmux window left/right
      "cmd+," = "send_text all \\x01,";
      "cmd+." = "send_text all \\x01.";

      "cmd+t" = "send_text all \\x01c";
      "cmd+w" = "send_text all \\x01&";
      "cmd+enter" = "send_text all \\x01\r";

      #
      # Splits
      #

      "cmd+d" = "send_text all \\x01%";
      "cmd+shift+d" = "send_text all \\x01\"";

      #
      # Navigation
      #

      "cmd+left" = "send_text all \\x01p";
      "cmd+right" = "send_text all \\x01n";

      #
      # Jump directly to windows
      #

      "cmd+1" = "send_text all \\x011";
      "cmd+2" = "send_text all \\x012";
      "cmd+3" = "send_text all \\x013";
      "cmd+4" = "send_text all \\x014";
      "cmd+5" = "send_text all \\x015";
      "cmd+6" = "send_text all \\x016";
      "cmd+7" = "send_text all \\x017";
      "cmd+8" = "send_text all \\x018";
      "cmd+9" = "send_text all \\x019";

      #
      # Rename current tmux window
      #

      "cmd+shift+r" = "send_text all \\x01w";

      #
      # Pane navigation
      #

      "cmd+h" = "send_text all \\x01h";
      "cmd+j" = "send_text all \\x01j";
      "cmd+k" = "send_text all \\x01k";
      "cmd+l" = "send_text all \\x01l";

      #
      # Resize panes
      #

      "cmd+shift+h" = "send_text all \\x01H";
      "cmd+shift+j" = "send_text all \\x01J";
      "cmd+shift+k" = "send_text all \\x01K";
      "cmd+shift+l" = "send_text all \\x01L";

      #
      # Kill pane
      #

      "cmd+backspace" = "send_text all \\x01x";

      #
      # Zoom pane toggle
      #

      "cmd+z" = "send_text all \\x01z";

      #
      # Sessions
      #

      "cmd+e" = "send_text all \\x01s";

      #
      # Reload tmux config
      #

      "cmd+r" = "send_text all \\x01r";

    };
  };

  xdg.configFile."kitty/sessions/.keep".text = "";
}
