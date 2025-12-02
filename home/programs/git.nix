{
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sudip Roy";
        email = "sudiproy20yo@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
}
