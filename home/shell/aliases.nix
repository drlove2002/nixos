{ pkgs, config, ... }:
{
  home.shellAliases = {
    copy = "xclip -selection clipboard";
    paste = "xclip -selection clipboard -o";
    nixbuild = "sudo nixos-rebuild switch --upgrade";
    nixgc = "sudo nix-collect-garbage";
    nixrmold = "sudo nix-env --delete-generations old";
    htop = "btop";
    cd = "z";
    cat = "bat";
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
