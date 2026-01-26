{...}: {
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka Nerd Font";
      enable_audio_bell = false;
      shell = "zsh";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      scrollback_lines = 10000;
      scrollback_pager_history_size = 10;
      mouse_hide_wait = 3.0;
      hide_window_decorations = "yes";
      notify_on_cmd_finish = "invisible 20";
    };
  };
}
