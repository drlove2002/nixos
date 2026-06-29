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
    llmAgents.toon
  ];
  # agent-browser dashboard pnpm build fails on aarch64-darwin.
  # Install manually: nix build github:numtide/llm-agents.nix#agent-browser
  # chromium not in nix on aarch64-darwin — install via: brew install --cask google-chrome
}
