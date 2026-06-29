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
    ./shell/starship.nix
    ./shell/btop.nix
    ./shell/scripts
    ./shell/bat.nix
    ./shell/gpg.nix
    ./shell/zsh.nix
    ./desktop/shared.nix
    ./programs/ai-packages.nix
    ./programs/nix.nix
    ./programs/rust.nix
    ./programs/git
    ./programs/neofetch.nix
    ./programs/atuin.nix
    ./programs/dev.nix
  ];
  home = {
    username = username;
    homeDirectory = lib.mkForce "/Users/${username}";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
