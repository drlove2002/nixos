{pkgs, config, ...}: let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;

    shellAliases = {
      copy = "^xclip -selection clipboard";
      paste = "^xclip -selection clipboard -o";
      nixbuild = "sudo nixos-rebuild switch";
      nixgc = "sudo nix-collect-garbage";
      nixrmold = "sudo nix-env --delete-generations old";
      ww = "ssh ubuntu@35.171.134.147";
    };                         

    extraConfig = ''
      # Custom Environment Variables
      $env.LESSHISTFILE = "${cache}/less/history"
      $env.LESSKEY = "${c}/less/lesskey"
      $env.WINEPREFIX = "${d}/wine"
      
      $env.EDITOR = "vim"
      $env.BROWSER = "firefox"
      $env.TERMINAL = "kitty"
      
      $env.DELTA_PAGER = "less -R"
      $env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
      
      $env.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}"
    '';
  };
}
