{lib, ...}: {
  options.programs.neovim.initLua = lib.mkOption {
    type = lib.types.lines;
    default = "";
  };

  options.programs.opencode.tui = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default = {};
  };
}
