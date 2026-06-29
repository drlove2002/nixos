{
  config,
  pkgs,
  ...
}: let
  homeDir = config.home.homeDirectory;
  pocketTtsCli = "${homeDir}/.config/ai/extensions/pi-tts/bin/pocket-tts-cli";
in {
  # --- Pocket TTS (replaces systemd user service) ---
  launchd.user.agents.pocket-tts = {
    serviceConfig = {
      Program = pocketTtsCli;
      ProgramArguments = [
        "${pocketTtsCli}"
        "serve"
        "--host"
        "127.0.0.1"
        "--port"
        "18080"
      ];
      EnvironmentVariables = {
        POCKET_TTS_VOICES_DIR = "${homeDir}/.cache/pocket-tts";
      };
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "${homeDir}/.local/state/pocket-tts/stdout.log";
      StandardErrorPath = "${homeDir}/.local/state/pocket-tts/stderr.log";
    };
  };

  # --- Guardrails updater (replaces systemd timer + oneshot service) ---
  launchd.user.agents.guardrails-updater = {
    serviceConfig = {
      Program = "${pkgs.python3}/bin/python3";
      ProgramArguments = [
        "${pkgs.python3}/bin/python3"
        "${homeDir}/.config/ai/scripts/update-guardrails.py"
      ];
      StartInterval = 86400; # daily (seconds)
      RunAtLoad = true;
      StandardOutPath = "${homeDir}/.local/state/guardrails-updater/stdout.log";
      StandardErrorPath = "${homeDir}/.local/state/guardrails-updater/stderr.log";
    };
  };

  # --- Docs fetcher (replaces systemd timer + oneshot service) ---
  launchd.user.agents.fetch-docs = {
    serviceConfig = {
      Program = "${pkgs.bash}/bin/bash";
      ProgramArguments = [
        "${pkgs.bash}/bin/bash"
        "${homeDir}/.config/ai/scripts/fetch-docs.sh"
      ];
      EnvironmentVariables = {
        PATH = "${pkgs.git}/bin:${pkgs.findutils}/bin:${pkgs.coreutils}/bin";
      };
      StartInterval = 604800; # weekly (seconds)
      RunAtLoad = true;
      StandardOutPath = "${homeDir}/.local/state/fetch-docs/stdout.log";
      StandardErrorPath = "${homeDir}/.local/state/fetch-docs/stderr.log";
    };
  };

  # --- Zen browser backup (replaces systemd user service) ---
  launchd.user.agents.zen-backup = {
    serviceConfig = {
      Program = "${pkgs.bash}/bin/bash";
      ProgramArguments = [
        "${pkgs.bash}/bin/bash"
        "${homeDir}/.local/bin/zen-backup"
      ];
      StartInterval = 3600; # hourly
      RunAtLoad = false;
      StandardOutPath = "${homeDir}/.local/state/zen-backup/stdout.log";
      StandardErrorPath = "${homeDir}/.local/state/zen-backup/stderr.log";
    };
  };
}
