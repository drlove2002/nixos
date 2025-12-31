{...}: {
  services.suwayomi-server = {
    enable = true;
    settings.server = {
      port = 4567;
      enableSystemTray = true;
      autoDownloadNewChapters = true;
      maxSourcesInParallel = 10;
      extensionRepos = [
        "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
      ];
    };
  };
}
