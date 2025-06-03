{
  config,
  lib,
  ...
}:
{
  options = {
    yazi.enable = lib.mkEnableOption "enables yazi";
  };

  config = lib.mkIf config.yazi.enable {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      # plugins = {};
      # settings = {};
    };
    catppuccin.yazi.enable = true;
  };
}
