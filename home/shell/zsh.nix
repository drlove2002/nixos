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

      export PNPM_HOME="/home/love/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      # Custom Environment Variables (Zsh specific or if not in common)
      export LESSHISTFILE="${cache}/less/history"
      export LESSKEY="${c}/less/lesskey"
    '';
  };
}
