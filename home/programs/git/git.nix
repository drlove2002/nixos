{pkgs, ...}: {
  home.packages = [pkgs.gh];

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

        # Force GitHub HTTPS to use SSH
        url = {
          "git@github.com:".insteadOf = "https://github.com/";
        };
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
