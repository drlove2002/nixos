{
  config,
  lib,
  ...
}: {
  home.file."${config.home.homeDirectory}/.local/bin" = {
    recursive = true;
    source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos/home/shell/scripts/bin");
  };
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
