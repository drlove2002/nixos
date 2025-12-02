{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all     trust
      # ... other auth rules ...

      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host  all      all     ::1/128        trust
    '';
  };

  services.redis = {
    enable = true;
    package = pkgs.unstable.redis;
  };
}
