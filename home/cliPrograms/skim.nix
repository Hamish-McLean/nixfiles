{
  config,
  lib,
  ...
}:
{
  options = {
    skim.enable = lib.mkEnableOption "enables skim";
  };

  config = lib.mkIf config.skim.enable {
    programs.skim = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    catppuccin.skim.enable = true;
  };
}
