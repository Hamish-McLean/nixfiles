/*
  Cosmic manager
  https://heitoraugustoln.github.io/cosmic-manager/
*/
{
  config,
  lib,
  ...
}:
{
  options = {
    cosmic.enable = lib.mkEnableOption "enables cosmic";
  };

  config = lib.mkIf config.cosmic.enable {
    programs.cosmic-files = {
      enable = true;
      settings = {
        # app_theme = cosmicLib.cosmic.mkRon "enum" "Dark";
      };
    };
    wayland.desktopManager.cosmic = {
      enable = true;

    };
  };
}
