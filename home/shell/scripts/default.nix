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
    "$HOME/.local/bin" # Wrapper scripts (highest priority)
    "$HOME/.local/share/claude/versions" # Self-updated binaries
  ];
}
