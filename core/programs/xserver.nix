{ user, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager.autoLogin = {
      enable = true;
      user = user;
    };
    libinput = {
      enable = true;
    };
  };
  # To prevent getting stuck at shutdown
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}
