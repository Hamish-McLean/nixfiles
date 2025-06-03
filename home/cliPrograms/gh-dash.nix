{
  config,
  lib,
  ...
}:
{
  options = {
    gh-dash.enable = lib.mkEnableOption "enables gh-dash";
  };

  config = lib.mkIf config.gh-dash.enable {
    programs.gh-dash = {
      enable = true;
    };
    catppuccin.gh-dash.enable = true;
  };
}
