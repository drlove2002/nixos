{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      ww = {
        hostname = "52.20.11.97";
        user = "ubuntu";
        identityFile = "~/.ssh/ww.pem";
      };
    };
  };
}
