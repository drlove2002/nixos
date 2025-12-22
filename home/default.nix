{
  user,
  ...
}:
{

  imports = [
    ./programs
    ./shell
    ./desktop
  ];

  # Home Manager
  home = {
    username = user;
    homeDirectory = "/home/love";

    stateVersion = "25.05"; # DO NOT CHANGE
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
