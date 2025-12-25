{...}: {
  security = {
    rtkit.enable = true;

    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };

    pam.services = {
      login.enableGnomeKeyring = true;
      swaylock = {}; # TODO: Need to use any of these pam
      hyprlock = {};
    };
  };
}
