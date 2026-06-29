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
    llmAgents.pi
    llmAgents.agent-browser
    llmAgents.toon
    pkgs.chromium
  ];
}
