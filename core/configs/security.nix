{ ... }:
{
  security = {
    rtkit.enable = true;

    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };

    pam.services = {
      swaylock = { }; # TODO: Need to use any of these pam
      hyprlock = { };
    };
  };
}
