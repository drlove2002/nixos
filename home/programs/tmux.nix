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
      # True color support
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Re-number windows when one closes
      set -g renumber-windows on

      # Pass extended key sequences (C-S-Left, etc.)
      set -g extended-keys on
    '';
  };
}
