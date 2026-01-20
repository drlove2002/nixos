{
  pkgs,
  config,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    package = pkgs.yazi.override {_7zz = pkgs._7zz-rar;};

    keymap.mgr.prepend_keymap = [
      {
        on = "y";
        run = [
          "shell -- for path in %s; do echo \"file://$path\"; done | wl-copy -t text/uri-list"
          "yank"
        ];
        desc = "Yank + Clipboard";
      }
      {
        on = ["c" "c"];
        run = "shell 'cat \"$@\" | wl-copy'";
        desc = "File content -> clipboard";
      }
      {
        on = ["<C-d>"];
        run = "shell --block 'ncdu --color dark --confirm-quit \"$PWD\"'";
        desc = "Disk usage of selected (ncdu)";
      }
    ];
    settings = {
      yazi = {
        ratio = [
          1
          4
          3
        ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 600;
        max_height = 900;
        cache_dir = "${config.xdg.cacheHome}/yazi";
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };

      opener.play = [
        {
          run = "mpv --fullscreen \"$@\"";
          orphan = true;
          for = "unix";
        }
      ];

      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };
    };
  };
}
