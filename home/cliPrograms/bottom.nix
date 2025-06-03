{
  config,
  lib,
  ...
}:
{
  options = {
    bottom.enable = lib.mkEnableOption "enables bottom";
  };

  config = lib.mkIf config.bottom.enable {
    programs.bottom = {
      enable = true;
    };
    catppuccin.bottom.enable = true;
  };
}
