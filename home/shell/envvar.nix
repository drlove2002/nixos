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
    WINEPREFIX = "${config.xdg.dataHome}/wine";
    LANG = "C.UTF-8";
    LC_ALL = "C.UTF-8";
  };
}
