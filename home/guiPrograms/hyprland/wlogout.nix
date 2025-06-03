{
  config,
  lib,
  ...
}:
{
  options = {
    wlogout.enable = lib.mkEnableOption "enables wlogout";
  };

  config = lib.mkIf config.wlogout.enable {
    programs.wlogout = {
      enable = true;
      # layout = [];
      # style = {};
    };
    catppuccin.wlogout.enable = true;
  };
}
