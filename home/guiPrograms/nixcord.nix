/*
  Nixcord

  https://github.com/KaylorBen/nixcord
*/
{
  config,
  lib,
  ...
}:
{
  options = {
    nixcord.enable = lib.mkEnableOption "enables nixcord";
  };

  config = lib.mkIf config.nixcord.enable {
    programs.nixcord = {
      enable = true;
      config = {
        # Options at https://github.com/KaylorBen/nixcord/blob/main/docs/INDEX.md
        themeLinks = [
          "https://github.com/catppuccin/discord/blob/main/themes/mocha.theme.css"
          "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css"
        ];
        enabledThemes = [ "Catppuccin Mocha" ];
        # frameless = false;
        plugins = {
          # Plugin list at https://github.com/KaylorBen/nixcord/blob/main/docs/plugins.md
          alwaysAnimate.enable = true;
          accountPanelServerProfile.enable = true;
          alwaysExpandRoles.enable = true;
          betterFolders.enable = true;
          betterRoleContext.enable = true;
          betterSessions.enable = true;
          betterSettings.enable = true;
          betterUploadButton.enable = true;
          biggerStreamPreview.enable = true;
          clearURLs.enable = true;
          copyFileContents.enable = true;
          copyUserURLs.enable = true;
          crashHandler.enable = true;
          decor.enable = true;
          openInApp.enable = true;
          spotifyControls = {
            enable = true;
            hoverControls = true;
            useSpotifyUris = true;
          };
          youtubeAdblock.enable = true;
        };
      };
      vesktop.enable = true;
    };
  };
}
