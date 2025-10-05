{ pkgs, ... }:

{
  systemd.user.services.startDbContainers = {
    Unit = {
      Description = "Start DB containers";
      After = [ "network.target" "docker.service" ];
    };
    Service = {
      ExecStart = pkgs.writeShellScript "start-db-containers" ''
        #!/usr/bin/env bash
        docker run -d --restart unless-stopped --name postgres  -p 5432:5432 -v /var/lib/postgres:/var/lib/postgresql/data -e POSTGRES_USER=test -e POSTGRES_PASSWORD=test -e POSTGRES_DB=testdb postgres:17-alpine
        docker run -d --restart unless-stopped --name redis -p 6379:6379 -v /var/lib/redis:/data redis:8.0-alpine redis-server --maxmemory 8mb --maxmemory-policy noeviction --save 3600 1 900 10 300 100 60 1000 --dbfilename dump.rdb
      '';
      Type = "simple";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
