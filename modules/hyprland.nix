{
  config,
  inputs,
  lib,
  pkgs,
  system,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      # package = inputs.hyprland.packages.${system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };
  };
}
