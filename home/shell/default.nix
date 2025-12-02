let _ = builtins.trace "Loading Shell" null; in
{
  imports = [
    ./zsh
    ./common.nix
    ./starship.nix
    ./terminal.nix
  ];

}
