{
  config,
  lib,
  ...
}:
{
  options = {
    x.enable = lib.mkEnableOption "enables x";
  };

  config = lib.mkIf config.x.enable {
    programs.x = {

    };
  };
}
