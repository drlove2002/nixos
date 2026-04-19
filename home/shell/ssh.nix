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
      ww2 = {
        hostname = "44.218.138.24";
        user = "admin";
        identityFile = "~/.ssh/ww2.pem";
      };
      az = {
        hostname = "20.219.230.10";
        user = "azure";
        identityFile = "~/.ssh/azur.pem";
      };
      pi = {
        hostname = "100.96.186.96";
        user = "love";
        identityFile = "~/.ssh/id_ed25519";
      };
      test = {
        hostname = "3.233.125.107";
        user = "admin";
        identityFile = "~/.ssh/test.pem";
      };
    };
  };
}
