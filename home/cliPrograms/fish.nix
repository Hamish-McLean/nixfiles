{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    fish.enable = lib.mkEnableOption "enables fish";
  };
  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -U fish_greeting ""
      '';
      plugins = [
        {
          name = "colored-man-pages";
          src = pkgs.fishPlugins.colored-man-pages.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        {
          name = "pisces";
          src = pkgs.fishPlugins.pisces.src;
        }
        {
          name = "puffer";
          src = pkgs.fishPlugins.puffer.src;
        }
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge.src;
        }
      ];
    };
    catppuccin.fish.enable = true;
  };
}
