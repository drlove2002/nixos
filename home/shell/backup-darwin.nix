{
  config,
  pkgs,
  lib,
  ...
}: let
  zedBackup = pkgs.writeShellApplication {
    name = "zed-backup";
    runtimeInputs = with pkgs; [
      bash
      gnutar
      zstd
      coreutils
    ];
    text = ''
      ${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.local/bin/zed-backup
    '';
  };
  zenBackup = pkgs.writeShellApplication {
    name = "zen-backup-wrapped";
    runtimeInputs = with pkgs; [
      bash
      gnutar
      zstd
      coreutils
    ];
    text = ''
      ${pkgs.bash}/bin/bash ${config.home.homeDirectory}/.local/bin/zen-backup
    '';
  };
in {
  launchd.agents = {
    "com.sudiproy.zed-backup" = {
      enable = true;
      config = {
        Label = "com.sudiproy.zed-backup";
        ProgramArguments = [
          "${zedBackup}/bin/zed-backup"
        ];
        RunAtLoad = true;
        StartInterval = 21600;
        StandardOutPath = "${config.home.homeDirectory}/.local/share/zed-backup.log";
        StandardErrorPath = "${config.home.homeDirectory}/.local/share/zed-backup.log";
        ProcessType = "Background";
        KeepAlive = false;
        LowPriorityIO = true;
      };
    };
    "com.sudiproy.zen-backup" = {
      enable = true;
      config = {
        Label = "com.sudiproy.zen-backup";
        ProgramArguments = [
          "${zenBackup}/bin/zen-backup-wrapped"
        ];
        RunAtLoad = true;
        StartInterval = 21600;
        StandardOutPath = "${config.home.homeDirectory}/.local/share/zen-backup.log";
        StandardErrorPath = "${config.home.homeDirectory}/.local/share/zen-backup.log";
        ProcessType = "Background";
        KeepAlive = false;
        LowPriorityIO = true;
      };
    };
  };
}
