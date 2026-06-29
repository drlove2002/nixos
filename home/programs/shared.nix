{
  imports = [
    ./ai-packages.nix
    ./gui.nix
    ./dev.nix
    ./nix.nix
    ./rust.nix
    ./git
    ./discord
    ./neofetch.nix
    ./atuin.nix
    ./zed
    ./nvim
    ./browser
    ./spotify.nix
  ];
  # obs.nix — OBS Studio doesn't support aarch64-darwin
