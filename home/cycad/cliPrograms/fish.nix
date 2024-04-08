{ config, lib, ... }:
{
  options = {
    fish.enable = lib.mkEnableOption "enables fish";
  };
  config = lib.mkIf config.fish.enable {
    xdg.enable = true; # Required for fish theming
    programs.fish = {
      enable = true;
      catppuccin.enable = true;
      interactiveShellInit = ''
        set -U fish_greeting ""
      '';
      # plugins = [ { name = "tide"; src = pkgs.fishPlugins.tide.src; } ];
      
      # plugins = with pkgs.fishPlugins; [
        # fzf-fish.src
        # pure.src
        # tide.src
      # ];
    };
  };
}