{
  inputs,
  pkgs,
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
}
