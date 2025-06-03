/*
Feh image viewer
https://feh.finalrewind.org/
https://github.com/derf/feh
*/
{
  config,
  lib,
  ...
}:
{
  options = {
    feh.enable = lib.mkEnableOption "enables feh";
  };

  config = lib.mkIf config.feh.enable {
    programs.feh = {
      enable = true;
      # keybindings = {};
      # themes = {};
    };
  };
}
