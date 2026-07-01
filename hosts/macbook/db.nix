{ config, pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    authentication = ''
      #type database DBuser origin-address auth-method
      local all      all     trust
      host  all      all     127.0.0.1/32   trust
      host  all      all     ::1/128        trust
    '';
  };

  services.redis = {
    enable = true;
    package = pkgs.unstable.redis;
  };

  system.activationScripts.preActivation.text = ''
    mkdir -p /var/lib/postgresql/17 /var/lib/redis
    if [ "$(stat -f '%Su' /var/lib/postgresql 2>/dev/null)" != "sudiproy" ]; then
      chown sudiproy /var/lib/postgresql /var/lib/postgresql/17 /var/lib/redis
    fi
    ZEN_EXT="/Users/sudiproy/Library/Application Support/Zen/Profiles/sudiproy/extensions"
    if [ -d "$ZEN_EXT" ]; then
      chown -R sudiproy:staff "$ZEN_EXT"
      chmod -R u+w "$ZEN_EXT"
    else
      mkdir -p "$ZEN_EXT"
      chown sudiproy:staff "$ZEN_EXT"
    fi
  '';
}
