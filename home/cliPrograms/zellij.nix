{
  config,
  lib,
  ...
}:
{
  options = {
    zellij.enable = lib.mkEnableOption "enables zellij";
  };

  config = lib.mkIf config.zellij.enable {
    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      settings = {
        # pane_frames = false;
        # simplified_ui = true;
        ui.pane_frames.rounded_corners = true;
      };
    };
    catppuccin.zellij.enable = true;
  };
}
