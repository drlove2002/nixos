{
  config,
  pkgs,
  ...
}: let
  scriptPath = "${config.home.homeDirectory}/.config/ai/scripts/fetch-docs.sh";
in {
  systemd.user.services.fetch-docs = {
    Unit = {
      Description = "Fetch upstream docs for Nextcord and Discord.py";
      After = ["network-online.target"];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = false;
      ExecStart = "${pkgs.bash}/bin/bash ${scriptPath}";
      Environment = "PATH=${pkgs.git}/bin:${pkgs.findutils}/bin:${pkgs.coreutils}/bin";
    };
  };

  systemd.user.timers.fetch-docs = {
    Unit = {
      Description = "Weekly docs refresh";
    };

    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
      AccuracySec = "1h";
    };

    Install.WantedBy = ["timers.target"];
  };
}
