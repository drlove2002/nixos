{ ... }:
{
  # Install atuin via home-manager module
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      openRegistration = false;
      inline_height = 25;
      invert = true;
      records = true;
      search_mode = "skim";
      secrets_filter = true;
      style = "compact";
    };
    flags = [ "--disable-up-arrow" ];
  };
}
