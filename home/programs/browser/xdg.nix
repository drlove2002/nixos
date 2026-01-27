{
  inputs,
  pkgs,
  username,
  ...
}: {
  stylix.targets.zen-browser.profileNames = [username];
  xdg.mimeApps = let
    value = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta.meta.desktopFileName;
    associations = builtins.listToAttrs (
      map (name: {inherit name value;}) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/ftp"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "application/pdf"
        "text/html"
      ]
    );
  in {
    associations.added = associations;
    defaultApplications = associations;
  };
}
