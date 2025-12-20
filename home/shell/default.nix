let
  _ = builtins.trace "Loading Shell" null;
in
{
  imports = [
    ./zsh.nix
    ./aliases.nix
    ./common.nix
    ./starship.nix
    ./terminal.nix
    ./btop.nix
    ./scripts
  ];

}
