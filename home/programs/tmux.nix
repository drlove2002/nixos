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
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Re-number windows when one closes
      set -g renumber-windows on

      # Pass extended key sequences (C-S-Left, etc.)
      set -g extended-keys on
    '';
  };
}
