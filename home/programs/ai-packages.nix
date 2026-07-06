{ inputs, pkgs, lib, ... }:
let llmAgents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = [
    llmAgents.pi
    llmAgents.opencode
    llmAgents.toon
    pkgs.agent-browser
  ] ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
    pkgs.chromium
  ];
}
