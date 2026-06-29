{...}: let
  shellAliases = {
    ff = "fastfetch";
    c = "clear";
    nb = "~/.local/bin/nb";
    nbu = "~/.local/bin/nbu";
    ngc = "~/.local/bin/ngc";
    ne = "code ~/.config/nixos/";
    htop = "btop";
    code = "codium";
    cd = "z";
    cat = "bat";
    grep = "rg";
    find = "fd";
    fzf = "sk";
    bm = "bashmount";
    ssh = "kitten ssh";

    ls = "eza --icons always"; # default view
    ll = "eza -bhl --icons --group-directories-first"; # long list
    la = "eza -abhl --icons --group-directories-first"; # all list
    lt = "eza --tree --level=2 --icons"; # tree
  };
in {
  home = {
    inherit shellAliases;
  };
  programs.zsh = {
    inherit shellAliases;
  };
  programs.bash = {
    enable = true;
    inherit shellAliases;
  };
}
