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
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    LANG = "C.UTF-8";
    LC_ALL = "C.UTF-8";
    NIXOS_CONFIG_DIR = "${config.xdg.configHome}/nixos";
    MPLBACKEND = "TkAgg";
    RAG_HOME = "${config.xdg.configHome}/ai/rag";
    RAG_PYTHON = "${config.xdg.configHome}/ai/rag/venv/bin/python";
    RAG_APP = "${config.xdg.configHome}/ai/rag/app/main.py";
  };
}
