{ pkgs, config, ... }:
{
  home.shellAliases = {
    ff = "fastfetch";
    c = "clear";
    copy = "xclip -selection clipboard";
    paste = "xclip -selection clipboard -o";
    nb = "nix flake update && nh os switch";
    ngc = "nh clean all && sudo nix-env --delete-generations old";
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
}
