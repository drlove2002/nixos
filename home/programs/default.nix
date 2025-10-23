{
  imports = [
    ./common.nix
    ./rust.nix
    ./db.nix
    ./git.nix
    ./xdg.nix
    ./vim.nix
    ./discord.nix
  ];

  # add environment variables
  home.sessionVariables = {
  };

  home.shellAliases = {
  };
}
