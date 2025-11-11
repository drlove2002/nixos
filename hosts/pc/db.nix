{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
  };

  services.redis = {
    enable = true;
    package = pkgs.unstable.redis;
  };
}
