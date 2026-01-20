{
  config,
  pkgs,
  ...
}: {
  systemd.user.startServices = "sd-switch";

  systemd.user.services.zenBackup = {
    Unit = {
      Description = "Zen Browser profile backup to external drive";
      After = ["dbus.service" "graphical-session-pre.target"];
      PartOf = ["graphical-session.target"];
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.writeShellApplication {
        name = "zen-backup";
        runtimeInputs = [
          pkgs.bash
          pkgs.gnutar
          pkgs.zstd
          pkgs.coreutils
          pkgs.findutils
          pkgs.util-linux
        ];
        text = ''
          ${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.local/bin/zen-backup
        '';
      }}/bin/zen-backup";

      Type = "oneshot";
      RemainAfterExit = false;
    };
  };
}
