{config, ...}: let
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      path = "${cache}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "gh"
        "git"
        "sudo"
      ];
    };

    initContent = ''
      # Load environment variables from ~/.config/.env
      if [ -f "${c}/.env" ]; then
        set -a
        source "${c}/.env"
        set +a
      fi

      export PNPM_HOME="${config.home.homeDirectory}/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      # Custom Environment Variables (Zsh specific or if not in common)
      export LESSHISTFILE="${cache}/less/history"
      export LESSKEY="${c}/less/lesskey"

      # Auto-start tmux: every terminal attaches to the main session
      if [[ -z "$TMUX" ]] && [[ -t 0 ]] && (( $+commands[tmux] )); then
        exec tmux new-session -A -s main
      fi
    '';
  };
}
