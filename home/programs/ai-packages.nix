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
  ];
  # chromium not in nix on aarch64-darwin — install via: brew install --cask google-chrome
}
