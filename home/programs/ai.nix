{
  inputs,
  pkgs,
  ...
}: let
  llmAgents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = [
    llmAgents.codex
    llmAgents.opencode
    # llmAgents.pi # We run this locally from ~/Projects/pi-mono
  ];

  # Make a wrapper script so 'pi' runs from your local clone
  home.file.".local/bin/pi" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      cd ~/Projects/pi-mono/packages/coding-agent
      exec npx tsx src/index.ts "$@"
    '';
  };
}
