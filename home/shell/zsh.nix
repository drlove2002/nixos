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

      export RUSTUP_BIN="/opt/homebrew/opt/rustup/bin"
      case ":$PATH:" in
        *":$RUSTUP_BIN:"*) ;;
        *) export PATH="$RUSTUP_BIN:$PATH" ;;
      esac

      export CARGO_HOME="${config.home.homeDirectory}/.cargo"
      case ":$PATH:" in
        *":$CARGO_HOME/bin:"*) ;;
        *) export PATH="$CARGO_HOME/bin:$PATH" ;;
      esac

      if [[ "$OSTYPE" == darwin* ]] && [ -d "/opt/homebrew/opt/libiconv" ]; then
        case ":$LIBRARY_PATH:" in
          *":/opt/homebrew/opt/libiconv/lib:"*) ;;
          *) export LIBRARY_PATH="/opt/homebrew/opt/libiconv/lib''${LIBRARY_PATH:+:$LIBRARY_PATH}" ;;
        esac
        case ":$CPATH:" in
          *":/opt/homebrew/opt/libiconv/include:"*) ;;
          *) export CPATH="/opt/homebrew/opt/libiconv/include''${CPATH:+:$CPATH}" ;;
        esac
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
