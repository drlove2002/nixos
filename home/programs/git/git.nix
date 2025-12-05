{
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.gh ];

  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Sudip Roy";
          email = "sudiproy20yo@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = "true";
      };
    };
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        keep-plus-minus-markers = true;
        light = false;
        line-numbers = true;
        navigate = true;
        width = 280;
      };
    };
  };
}
