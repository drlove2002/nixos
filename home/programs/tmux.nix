{ ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    clock24 = true;
    baseIndex = 1;
    historyLimit = 50000;
    shortcut = "a";
    escapeTime = 0;

    extraConfig = ''
      # Disable status bar — kitty handles all UI
      set -g status off

      # True color support
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Split panes in current directory
      bind \\ split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind C new-window -c "#{pane_current_path}"
      bind X kill-pane
      bind Q kill-window

      # Vim-style pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Window navigation
      bind n next-window
      bind p previous-window
      bind 1 select-window -t 1
      bind 2 select-window -t 2
      bind 3 select-window -t 3
      bind 4 select-window -t 4
      bind 5 select-window -t 5
      bind 6 select-window -t 6
      bind 7 select-window -t 7
      bind 8 select-window -t 8
      bind 9 select-window -t 9

      # Re-number windows when one closes
      set -g renumber-windows on

      # Pass extended key sequences (C-S-Left, etc.)
      set -g extended-keys on
    '';
  };
}
