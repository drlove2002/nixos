{
  stdenv,
  fetchurl,
  unzip,
  undmg,
  lib,
}:
stdenv.mkDerivation {
  pname = "hammerspoon";
  version = "1.1.1";

  src = fetchurl {
    url = "https://github.com/Hammerspoon/hammerspoon/releases/download/1.1.1/Hammerspoon-1.1.1.zip";
    sha256 = "11bb1c90faf5427f37c7bd4fe7eab9774ae43e1d5cb020c5b3088dac32849efa";
  };

  nativeBuildInputs = [unzip];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/Applications
    cp -r Hammerspoon.app $out/Applications/
  '';

  meta = {
    description = "Desktop automation application for macOS";
    homepage = "https://www.hammerspoon.org";
    platforms = lib.platforms.darwin;
    license = lib.licenses.mit;
  };
}
