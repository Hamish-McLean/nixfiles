{
  config,
  lib,
  ...
}:
{
  options = {
    gitui.enable = lib.mkEnableOption "enables gitui";
  };
  config = lib.mkIf config.gitui.enable {
    programs.gitui = {
      enable = true;
    };
    catppuccin.gitui.enable = true;
  };
}
