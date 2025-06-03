{
  config,
  lib,
  ...
}:
{
  options = {
    carapace.enable = lib.mkEnableOption "enables carapace";
  };

  config = lib.mkIf config.carapace.enable {
    programs.carapace = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableNushellIntegration = true;
    };
  };
}
