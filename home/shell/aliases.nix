{ pkgs, config, ... }:
{
  home.shellAliases = {
    ff = "fastfetch";
    copy = "xclip -selection clipboard";
    paste = "xclip -selection clipboard -o";
    nb = "sudo nixos-rebuild switch --upgrade";
    ngc = "sudo nix-collect-garbage";
    htop = "btop";
    code = "codium";
    cd = "z";
    cat = "bat";
    grep = "rg";
    find = "fd";

    ls = "eza --icons always"; # default view
    ll = "eza -bhl --icons --group-directories-first"; # long list
    la = "eza -abhl --icons --group-directories-first"; # all list
    lt = "eza --tree --level=2 --icons"; # tree

    nixedit = "code ~/.config/nixos/";
  };

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
