{...}: {
  users.users.love = {
    isNormalUser = true;
    description = "Dr Love";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
    ];
  };
}
