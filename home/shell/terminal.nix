{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka";
      size = 16;
    };
    settings = {
      enable_audio_bell = false;
      shell = "zsh";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      background_opacity = 0.5;
      scrollback_lines = 10000;
      scrollback_pager_history_size = 10;
      mouse_hide_wait = 3.0;
      hide_window_decorations = "yes";
      notify_on_cmd_finish invisible = 20;
    };
    themeFile = "kanagawa_dragon";
  };
  programs.ssh.matchBlocks = {
    ww = {
      hostname = "52.20.11.97";
      user = "ubuntu";
      identityFile = "~/.ssh/ww.pem";
    };
  };

}
