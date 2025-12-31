{pkgs, ...}: {
  imports = [
    ./db.nix
    ./warp.nix
    ./wayland.nix
    ./xserver.nix
    ./services.nix
    ./suwayomi.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    glibcLocales
    killall
    ((ffmpeg-full.override {withUnfree = true;}).overrideAttrs (_: {doCheck = false;}))
  ];

  programs = {
    firefox.enable = true;
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nix-ld.enable = true;
    # nix-ld.libraries = with pkgs; [];
  };
}
