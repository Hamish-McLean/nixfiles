{
  config,
  lib,
  ...
}:
{
  options = {
    fzf.enable = lib.mkEnableOption "enables fzf";
  };
  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      tmux.enableShellIntegration = true;
    };
    catppuccin.fzf.enable = true;
  };
}
