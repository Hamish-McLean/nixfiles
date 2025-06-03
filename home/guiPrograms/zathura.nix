{
  config,
  lib,
  ...
}:
{
  options = {
    zathura.enable = lib.mkEnableOption "enables zathura";
  };

  config = lib.mkIf config.zathura.enable {
    programs.zathura = {
      enable = true;
      mappings = { };
      options = { };
    };
    catppuccin.zathura.enable = true;
  };
}
