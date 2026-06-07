{
  config,
  pkgs,
  ...
}: let
  scriptPath = "${config.home.homeDirectory}/.config/ai/scripts/update-guardrails.py";
in {
  systemd.user.services.guardrails-updater = {
    Unit = {
      Description = "Update Worldwide AI guardrails from session logs";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = false;
      ExecStart = "${pkgs.python3}/bin/python3 ${scriptPath}";
    };
  };

  systemd.user.timers.guardrails-updater = {
    Unit = {
      Description = "Daily guardrails update from session logs";
    };

    Timer = {
      OnCalendar = "daily";
      Persistent = true;  # catch up if machine was off
      AccuracySec = "5min";
    };

    Install.WantedBy = ["timers.target"];
  };
}
