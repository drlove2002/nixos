{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  programs.nixcord = {
    enable = true; # Enable Nixcord (It also installs Discord)
    vesktop.enable = true; # Vesktop
    quickCss = builtins.readFile ./kanagawa.theme.css;
    config = {
      useQuickCss = true;
      frameless = true; # Set some Vencord/Equicord options
      plugins = {
        betterFolders.enable = true;
        betterGifAltText.enable = true;
        betterGifPicker.enable = true;
        betterNotesBox.enable = true;
        betterSessions.enable = true;
        betterSettings.enable = true;
        callTimer.enable = true;
        copyEmojiMarkdown.enable = true;
        favoriteEmojiFirst.enable = true;
        noF1.enable = true;
        betterRoleContext.enable = true;
        crashHandler.enable = true;
        memberCount.enable = true;
        mentionAvatars.enable = true;
        messageLatency.enable = true;
        showHiddenThings.enable = true;
        webContextMenus.enable = true;
        webKeybinds.enable = true;
        webScreenShareFixes.enable = true;
        alwaysAnimate.enable = true;
      };
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };
}
