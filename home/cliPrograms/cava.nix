{
  config,
  lib,
  ...
}:
{
  options = {
    cava.enable = lib.mkEnableOption "enables cava";
  };

  config = lib.mkIf config.cava.enable {
    programs.cava = {
      enable = true;
    };
    catppuccin.cava.enable = true;
  };
}
