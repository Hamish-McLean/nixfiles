{
  config,
  lib,
  ...
}:
{
  options = {
    eza.enable = lib.mkEnableOption "enables eza";
  };
  config = lib.mkIf config.eza.enable {
    programs.eza = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      colors = "auto";
      icons = "auto";
      git = true;
      extraOptions = [ ];
    };
  };
}
