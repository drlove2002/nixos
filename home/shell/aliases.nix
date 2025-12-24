{ pkgs, config, ... }:
{
  home.shellAliases = {
    ff = "fastfetch";
    c = "clear";
    copy = "xclip -selection clipboard";
    paste = "xclip -selection clipboard -o";
    nb = "sudo nixos-rebuild switch --upgrade";
    nbu = "nix flake update && nb";
    ngc = "sudo nix-collect-garbage -d";
    ne = "code ~/.config/nixos/";
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

  };
}
