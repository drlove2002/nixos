{...}: {
  # Install lazygit via home-manager module
  programs.lazygit = {
    enable = true;

    settings = {
      git = {
        log.showWholeGraph = true;
        pager = {
          colorArg = "always";
          pager = "delta --color-only --dark --paging=never";
        };
      };
    };
  };
}
