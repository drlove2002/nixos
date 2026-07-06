{ lib, stdenv, fetchurl }:

let
  version = "0.31.1";
  npmHash = "07j286aicaa3jhhyaw1q0sbm58nc009ygycs20chsmn7p6jzg5d4";

  # Map nix system to the binary name inside the npm tarball
  binaryName = {
    "aarch64-darwin" = "agent-browser-darwin-arm64";
    "x86_64-darwin" = "agent-browser-darwin-x64";
    "x86_64-linux" = "agent-browser-linux-x64";
    "aarch64-linux" = "agent-browser-linux-arm64";
  }.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

in
stdenv.mkDerivation {
  pname = "agent-browser";
  inherit version;

  src = fetchurl {
    url = "https://registry.npmjs.org/agent-browser/-/agent-browser-${version}.tgz";
    sha256 = npmHash;
  };

  sourceRoot = "package";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp bin/${binaryName} $out/bin/agent-browser
    chmod +x $out/bin/agent-browser
  '';

  meta = with lib; {
    description = "Browser automation CLI for AI agents";
    homepage = "https://agent-browser.dev";
    license = licenses.asl20;
    maintainers = [];
    platforms = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
  };
}
