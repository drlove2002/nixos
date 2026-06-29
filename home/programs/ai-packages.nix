{
  inputs,
  pkgs,
  lib,
  ...
}: let
  llmAgents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = [
    llmAgents.codex
    llmAgents.opencode
    llmAgents.pi
    llmAgents.toon
  ] ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
    llmAgents.agent-browser
    pkgs.chromium
  ];
}
