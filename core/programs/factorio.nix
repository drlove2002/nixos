{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    factorio-headless
  ];
  services.factorio = {
    enable = true;
    openFirewall = true;
    requireUserVerification = false;
    autosave-interval = 5;
    loadLatestSave = true;
    extraSettingsFile = "/var/lib/factorio/.config/factorio/settings.json";
    admins = ["drlove.bot"];
  };
  systemd.services.factorio.wantedBy = lib.mkForce [];
}
