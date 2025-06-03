{
  config,
  lib,
  ...
}:
{
  options = {
    lazygit.enable = lib.mkEnableOption "enables lazygit";
  };

  config = lib.mkIf config.lazygit.enable {
    programs.lazygit = {
      enable = true;
    };
    catppuccin.lazygit.enable = true;
  };
}
