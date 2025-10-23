{ lib, pkgs, ... }:


{
  home.activation = {
    startDbContainers = lib.hm.dag.entryAfter ["etc"] ''
      #!/usr/bin/env bash

      export PATH=/run/current-system/sw/bin:$PATH

      # Check if 'sql' container exists
      if ! docker container inspect sql >/dev/null 2>&1; then
        docker run -d --restart unless-stopped --name sql -p 5432:5432 \
          -v /var/lib/postgres:/var/lib/postgresql/data \
          -e POSTGRES_USER=test -e POSTGRES_PASSWORD=test -e POSTGRES_DB=testdb \
          postgres:17-alpine
      else
        echo "Container 'sql' already exists. Skipping..."
      fi

      # Create Docker volume if not exists (ignore error)
      docker volume create redis-data || true

      # Check if 'redis' container exists
      if ! docker container inspect redis >/dev/null 2>&1; then
        docker run -d --restart unless-stopped --name redis -p 6379:6379 \
          -v redis-data:/data \
          redis:8.0-alpine redis-server --maxmemory 8mb --maxmemory-policy noeviction \
          --save 3600 1 900 10 300 100 60 1000 --dbfilename dump.rdb
      else
        echo "Container 'redis' already exists. Skipping..."
      fi
  '';
  };
}
