{
  pkgs,
  config,
  lib,
  ...
}: let
  cfgDir = "${config.xdg.configHome}/nixos/home/desktop/configs";
  inherit (lib) hm;

  # Properly codesigned yabai binary from upstream release (same source nixpkgs uses).
  yabaiSrc = pkgs.yabai.src;
in {
  home.packages = with pkgs; [ skhd ];

  # Copy configs (mutable, you can edit them directly).
  home.activation.yabaiSkhdConfig = hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.config/yabai $HOME/.config/skhd
    cp -f ${cfgDir}/yabai/yabairc $HOME/.config/yabai/yabairc
    cp -f ${cfgDir}/skhd/skhdrc   $HOME/.config/skhd/skhdrc
  '';

  # Copy properly-signed yabai binary to stable path.
  # The nix store has a read-only adhoc-signed copy — we need the real
  # upstream codesigned binary for the scripting addition on Apple Silicon.
  home.activation.yabaiBinary = hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -f /usr/local/bin/yabai-official ]; then
      cp ${yabaiSrc}/bin/yabai /usr/local/bin/yabai-official
      chmod 755 /usr/local/bin/yabai-official
    fi
  '';

  # User launchd agents
  launchd.agents.yabai = {
    enable = true;
    config = {
      Label = "com.koekeishiya.yabai";
      ProgramArguments = ["/usr/local/bin/yabai-official"];
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Interactive";
    };
  };

  launchd.agents.skhd = {
    enable = true;
    config = {
      Label = "com.koekeishiya.skhd";
      ProgramArguments = ["${pkgs.skhd}/bin/skhd"];
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Interactive";
    };
  };
}
