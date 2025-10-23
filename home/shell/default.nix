let _ = builtins.trace "Loading Shell" null; in
{
  imports = [
    ./nushell
    ./common.nix
    ./starship.nix
    ./terminal.nix
  ];

}
