{ pkgs, config, ... }:
{
  home.shellAliases = {
    ff = "fastfetch";
    copy = "xclip -selection clipboard";
    paste = "xclip -selection clipboard -o";
    nixbuild = "sudo nixos-rebuild switch --upgrade";
    nixgc = "sudo nix-collect-garbage";
    nixrmold = "sudo nix-env --delete-generations old";
    htop = "btop";
    cd = "z";
    cat = "bat";
    ag = "antigravity";
    grep = "rg";
    find = "fd";

    ls = "eza --icons always"; # default view
    ll = "eza -bhl --icons --group-directories-first"; # long list
    la = "eza -abhl --icons --group-directories-first"; # all list
    lt = "eza --tree --level=2 --icons"; # tree
  };

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "zen-browser";
    TERMINAL = "kitty";
    DELTA_PAGER = "less -R";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    WINEPREFIX = "${config.xdg.dataHome}/wine";
  };
}
