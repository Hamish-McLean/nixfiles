{ config, lib, ... }:
{
  options = {
    pandoc.enable = lib.mkEnableOption "enables pandoc";
  };
  config = lib.mkIf config.pandoc.enable {
    programs.pandoc = {
      enable = true;
    };
  };
}
