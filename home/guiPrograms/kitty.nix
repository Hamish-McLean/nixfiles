{
  config,
  lib,
  ...
}:
{
  options = {
    kitty.enable = lib.mkEnableOption "enables kitty";
  };

  config = lib.mkIf config.kitty.enable {

    programs.kitty = {
      enable = true;
      font.name = "JetBrainsMono";
      shellIntegration = {
        enableBashIntegration = true;
        enableFishIntegration = true;
      };
      settings = {
        hide_window_decorations = false; # Toggle white top bar
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
      };
    };

    catppuccin.kitty.enable = true;
  };
}
