{
  pkgs,
  config,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "zen-browser";
    TERMINAL = "kitty";
    DELTA_PAGER = "less -R";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    LANG = "C.UTF-8";
    LC_ALL = "C.UTF-8";
    NIXOS_CONFIG_DIR = "${config.xdg.configHome}/nixos";
    MPLBACKEND = "TkAgg";
    RAG_HOME = "${config.xdg.configHome}/ai/rag";
    RAG_PYTHON = "${config.xdg.configHome}/ai/rag/venv/bin/python";
    RAG_APP = "${config.xdg.configHome}/ai/rag/app/main.py";
    AGENT_BROWSER_CONFIG = "${config.xdg.configHome}/ai/browser-config.json";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.npm-global/bin"
  ];
}
