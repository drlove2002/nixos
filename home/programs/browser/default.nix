{
  inputs,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
    ./policies.nix
    ./settings.nix
    ./xdg-nixos.nix
  ];

  programs.zen-browser = {
    enable = true;
    profiles."${username}" = {
      id = 0;
      name = "${username}";
      path = "${username}";
      isDefault = true;
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        bitwarden
        vimium-c
        private-grammar-checker-harper
      ];
    };
  };

  home.activation = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    zenExtensionsDir = lib.hm.dag.entryBefore ["linkGeneration"] ''
      ZEN_DIR="$HOME/Library/Application Support/Zen"
      ZEN_PROFILE="$ZEN_DIR/Profiles/${username}"
      mkdir -p "$ZEN_PROFILE/extensions"
      PROFILES_INI="$ZEN_DIR/profiles.ini"
      if [ ! -f "$PROFILES_INI" ]; then
        {
          echo '[General]'
          echo 'StartWithLastProfile=1'
          echo ""
          echo '[Profile0]'
          echo 'Default=1'
          echo 'IsRelative=1'
          echo "Name=${username}"
          echo 'Path=Profiles/${username}'
        } > "$PROFILES_INI"
      fi
    '';
  };
}
