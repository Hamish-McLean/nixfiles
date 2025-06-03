{ config, lib, ... }:
{
  options = {
    helix.enable = lib.mkEnableOption "enables helix";
  };
  config = lib.mkIf config.helix.enable {
    programs.helix = {
      enable = true;
      catppuccin.enable = true;
      languages.language = [
        {
          name = "nix";
          scope = "source.nix";
          auto-format = true;
        }
      ];
    };
  };
}
