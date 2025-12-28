{
  inputs,
  pkgs,
  ...
}: {
  stylix.targets.zen-browser.profileNames = ["love"];
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
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/html"
      ]
    );
  in {
    associations.added = associations;
    defaultApplications = associations;
  };
}
