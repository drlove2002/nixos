{
  config,
  inputs,
  pkgs,
  ...
}: let
  homeDir = config.home.homeDirectory;
  pocketTtsCli = "${homeDir}/.config/ai/extensions/pi-tts/bin/pocket-tts-cli";
in {
  imports = [
    ./ai-packages.nix
  ];

  systemd.user.services.pocket-tts = {
    Unit = {
      Description = "Pocket TTS server for Pi";
      After = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pocketTtsCli} serve --host 127.0.0.1 --port 18080";
      Environment = "POCKET_TTS_VOICES_DIR=${homeDir}/.cache/pocket-tts";
      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install.WantedBy = ["default.target"];
  };
}
