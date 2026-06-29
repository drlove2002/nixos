{...}: {
  security = {
    rtkit.enable = true;

    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };

    pam.services = {
      hyprlock.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
  };
}
