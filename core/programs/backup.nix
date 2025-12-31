{pkgs, ...}: {
  system.activationScripts.zenBackup = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      export PATH=${pkgs.gnutar}/bin:${pkgs.zstd}/bin:${pkgs.coreutils}/bin:${pkgs.util-linux}/bin

      PROFILE="/home/love/.zen/love"
      BACKUP="/run/media/love/SHARED/backup"
      ARCHIVE="$BACKUP/zen.tar.zst"

      # ensure backup mount exists & is mounted
      if ! findmnt --target $BACKUP >/dev/null; then
        echo "Backup drive not mounted — skipping Zen backup"
        exit 0
      fi

      if [ ! -d "$PROFILE" ]; then
        echo "Profile folder not found: $PROFILE"
        exit 0
      fi

      echo "Creating archive…"

      tar --zstd -cf "$ARCHIVE" \
        -C "$PROFILE" \
        storage \
        places.sqlite \
        cookies.sqlite \
        cert9.db \
        key4.db \
        logins.json \
        extension-preferences.json \
        extensions.json \
        extension-settings.json \
        search.json.mozlz4 \
        sessionCheckpoints.json \
        sessionstore.jsonlz4 \
        prefs.js \
        storage.sqlite \
        containers.json \
        zen-keyboard-shortcuts.json
      echo "Done 🧡"
    '';
  };
}
