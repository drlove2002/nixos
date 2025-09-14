{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;
    userName = "Sudip Roy";
    userEmail = "sudiproy20yo@gmail.com";
    extraConfig = {
        init.defaultBranch = "main";
    };
  };
}
