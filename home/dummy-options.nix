{lib, ...}: {
  options = {
    programs.neovim.initLua = lib.mkOption {
      type = lib.types.lines;
      default = "";
    };
    programs.opencode.tui = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = {};
    };
    # Stylix vscode module maps over vscode+vscodium; HM 25.11 only has programs.vscode
    programs.vscodium = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "stub" // {default = false;};
          profiles = lib.mkOption {type = lib.types.attrsOf lib.types.anything; default = {};};
        };
      };
      default = {};
      internal = true;
    };

    # Stylix modules set sub-options that no longer exist in HM 25.11.
    # These are dead paths Nix validates even inside mkIf false.
    # Submodules silently absorb unknown attrs; flat attrsOf do not.
    programs.wezterm.settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = {};
    };

    # Stylix qt module sets qt.kvantum = { enable = true; themes = [...]; };
    # HM 25.11 does not have a kvantum sub-option under qt.
    qt.kvantum = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "stub" // {default = false;};
          settings = lib.mkOption {type = lib.types.attrsOf lib.types.anything; default = {};};
          themes = lib.mkOption {type = lib.types.listOf lib.types.package; default = [];};
        };
      };
      default = {};
    };
  };
}
