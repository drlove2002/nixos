{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;

    extensions = [
      "nix"
      "rust"
      "toml"
    ];

    extraPackages = with pkgs; [nixd];
  };

  home.file."${config.xdg.configHome}/zed/settings.json".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos/home/programs/zed/settings.json"
  );

  home.file."${config.xdg.configHome}/zed/keymap.json".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos/home/programs/zed/keymap.json"
  );

  home.file."${config.xdg.configHome}/zed/themes/kanagawa.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos/home/programs/zed/themes/kanagawa.json";
}
