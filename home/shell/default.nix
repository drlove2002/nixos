let
  _ = builtins.trace "Loading Shell" null;
in
{
  imports = [
    ./zsh
    ./aliases.nix
    ./common.nix
    ./starship.nix
    ./terminal.nix
  ];

}
