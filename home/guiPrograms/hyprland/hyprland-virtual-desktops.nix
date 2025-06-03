{
  config,
  inputs,
  lib,
  system,
  ...
}:
{
  options = {
    hyprland-virtual-desktops.enable = lib.mkEnableOption "enables hyprland-virtual-desktops";
  };

  config = lib.mkIf config.hyprland-virtual-desktops.enable {
    wayland.windowManager.hyprland = {
      plugins = [
        inputs.hyprland-virtual-desktops.packages.${system}.virtual-desktops
      ];
    };
  };
}
