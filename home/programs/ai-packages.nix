{ inputs, pkgs, lib, ... }:
let llmAgents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in { home.packages = [ llmAgents.pi llmAgents.opencode llmAgents.toon ]; }
