{ pkgs, ... }: let
  model = "/var/lib/ollama/models/blobs/sha256-6c780ea4641e835b2204981a4281c08bd42f92bf94517acde3f244f439c21081";
in {
  environment.systemPackages = [
    pkgs.unstable.llama-cpp
  ];

  systemd.services.llama-supergemma4 = {
    description = "llama.cpp server for supergemma4";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    serviceConfig = {
      ExecStart = "${pkgs.unstable.llama-cpp}/bin/llama-server --model ${model} --host 127.0.0.1 --port 11435 --ctx-size 4096 --no-webui --alias supergemma4";
      Restart = "always";
      RestartSec = "5s";
    };
  };
}
