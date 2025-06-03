{
  config,
  lib,
  ...
}:
{
  options = {
    freetube.enable = lib.mkEnableOption "enables freetube";
  };

  config = lib.mkIf config.freetube.enable {
    programs.freetube = {
      enable = true;
    };
    catppuccin.freetube.enable = true;
  };
}
