{
  config,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file."${config.xdg.configHome}/nvim" = {
    recursive = true;
    source = lib.mkForce (
      config.lib.file.mkOutOfStoreSymlink
      "${config.xdg.configHome}/nixos/home/programs/nvim/configs"
    );
  };
  stylix.targets.neovim.enable = false;
}
