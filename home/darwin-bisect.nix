{
  inputs, username, lib, config, ...
}: {
  disabledModules = [
    "targets/darwin/fonts.nix"
    "targets/darwin/linkapps.nix"
    "targets/darwin/copyapps.nix"
  ];
  imports = [
    ./dummy-options.nix
    ./shell/aliases.nix
    ./shell/common.nix
    ./shell/envvar.nix
    ./shell/kitty.nix
    ./shell/ssh.nix
  ];
  home = {
    username = username;
    homeDirectory = lib.mkForce "/Users/${username}";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
