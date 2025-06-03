{ config, lib, ... }:
{
  options = {
    direnv.enable = lib.mkEnableOption "enables direnv";
  };
  config = lib.mkIf config.direnv.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      # enableFishIntegration = true; # Already enabled
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
