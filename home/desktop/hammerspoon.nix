{pkgs, config, lib, ...}: {
  home.packages = [pkgs.hammerspoon];

  # Hammerspoon needs a real ~/.hammerspoon directory (not a symlink).
  # Use home.activation to copy init.lua from our config.
  home.activation.hammerspoonConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $HOME/.hammerspoon
    cp -f ${config.xdg.configHome}/hammerspoon/init.lua $HOME/.hammerspoon/init.lua
  '';
}
