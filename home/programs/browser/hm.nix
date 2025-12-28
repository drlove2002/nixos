{
  config,
  username,
  lib,
  ...
}: let
  sourceDir = "${config.xdg.configHome}/nixos/home/programs/browser/backup";
  targetDir = ".zen/${username}";

  # List of directories and files to sync
  # Directories will recursively include all contents
  itemsToSync = [
    "extension-preferences.json"
    "extension-settings.json"
    "places.sqlite"
    "places.sqlite-wal"
    "prefs.js"
    "sessionCheckpoints.json"
    "sessionstore-backups"
    "zen-keyboard-shortcuts.json"
  ];
in {
  home.file = lib.listToAttrs (
    map
    (item: {
      name = "${config.home.homeDirectory}/${targetDir}/${item}";
      value = {
        source = lib.mkForce (
          config.lib.file.mkOutOfStoreSymlink "${sourceDir}/${item}"
        );
        recursive = true; # This makes it work for both files AND directories
      };
    })
    itemsToSync
  );
}
