{
  config,
  lib,
  ...
}:
{
  options = {
    dunst.enable = lib.mkEnableOption "enables dunst";
  };

  config = lib.mkIf config.dunst.enable {
    services.dunst = {
      enable = true;
      # iconTheme = {};
      settings = {
        global = {
          font = "JetBrainsMono Nerd Font 10";
          frame_color = "#74c7ec";
          gap_size = 10;
          corner_radius = 10;
        };
      };
    };
  };
}
