{ ... }:
{
  programs.tmux = {
    enable = true;

    mouse = true;
    baseIndex = 1;
    historyLimit = 100000;
    escapeTime = 0;
    clock24 = false;

    # Ctrl+A
    shortcut = "a";

    extraConfig = ''
      ##### Terminal #####

      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      set -g focus-events on
      set -s extended-keys on
      set -as terminal-features ',xterm-256color:extkeys'
      bind-key -n S-Enter send-keys Escape "[13;2u"

      ##### General #####

      set -g renumber-windows on
      set -g detach-on-destroy off
      set -g history-limit 100000
      setw -g mode-keys vi

      ##### Don't rename windows automatically #####

      set -g allow-rename off
      set -g automatic-rename off

      ##### Status Bar #####

      set -g status-position bottom
      set -g status-interval 5
      set -g status-justify left

      set -g status-style "bg=#0d0c0c,fg=#c5c9c5"

      set -g message-style "bg=#7FB4CA,fg=#181616"

      set -g pane-border-style "fg=#54546D"
      set -g pane-active-border-style "fg=#7FB4CA"

      set -g window-status-style "fg=#727169"
      set -g window-status-current-style "fg=#E6C384,bold"

      set -g status-left ""
      set -g status-right "#[fg=#8ba4b0]🧠#(cpu_pct)%%  💾#(mem_pct)%%  #S"

      set -g window-status-format " #I:#W "
      set -g window-status-current-format "#[bold] #I:#W "

      ##### Windows #####

      bind c new-window -c "#{pane_current_path}"

      # Move current window left/right
      bind -r , swap-window -t -1 \; previous-window
      bind -r . swap-window -t +1 \; next-window

      bind w command-prompt \
        -I "#W" \
        "rename-window '%%'"

      bind & confirm-before -p "Kill window #W? (y/n)" kill-window

      bind n next-window
      bind p previous-window
      bind Tab last-window

      ##### Panes #####

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      bind x confirm-before -p "Kill pane? (y/n)" kill-pane

      ##### Pane Navigation #####

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      ##### Pane Resize #####

      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      ##### Sessions #####

      bind s choose-tree -Z

      ##### Reload #####

      bind r source-file ~/.config/tmux/tmux.conf \; display-message "tmux config reloaded"

      ##### Synchronize Panes #####

      bind y setw synchronize-panes

      ##### Easy Numbers #####

      bind 1 select-window -t 1
      bind 2 select-window -t 2
      bind 3 select-window -t 3
      bind 4 select-window -t 4
      bind 5 select-window -t 5
      bind 6 select-window -t 6
      bind 7 select-window -t 7
      bind 8 select-window -t 8
      bind 9 select-window -t 9

      ##### Vi Copy #####

      bind Enter copy-mode
    '';
  };
}
