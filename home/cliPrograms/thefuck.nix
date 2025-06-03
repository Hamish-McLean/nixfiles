{
  config,
  lib,
  ...
}:
{
  options = {
    thefuck.enable = lib.mkEnableOption "enables thefuck";
  };

  config = lib.mkIf config.thefuck.enable {
    programs.thefuck = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
