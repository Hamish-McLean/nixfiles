{ config, lib, pkgs, ... }:
{
  options = {
    gtk_config.enable = lib.mkEnableOption "enables gtk_config";
  };
  config = lib.mkIf config.gtk_config.enable {
    gtk = {
      enable = true;
      catppuccin.enable = true;
      # theme = {
      #   name = "Catppuccin-Mocha-Standard-Lavender-Dark";
      #   package = pkgs.catppuccin-gtk.override {
      #     accents = [ "lavender" ];
      #     size = "standard";
      #     # tweaks = [ "rimless" ];
      #     variant = "mocha";
      #   };
    };

    # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
    xdg.configFile = {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };
  };
}