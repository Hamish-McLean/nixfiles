{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    gnome_config.enable = lib.mkEnableOption "enables gnome_config";
  };

  config = lib.mkIf config.gnome_config.enable {
    # GNOME dconf settings
    # This requires gnome-tweaks, maybe assert this?
    dconf.settings =
      let # Find a way to read these values from home-manager.catppuccin
        # cat-flavour = "mocha";
        # cat-accent = "sapphire";
        user-font = "CodeNewRoman Nerd Font";
        user-font-size = "11";
        wallpaper = pkgs.fetchurl {
          url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/misc/rainbow.png";
          hash = "sha256-6uYCbzefvkXF1JBtSMkYPJhH60GIHhhAkO60UzlQ/U0=";
        };
      in
      {
        # Desktop background
        "org/gnome/desktop/background" = {
          picture-uri = "file://${wallpaper}";
        };

        # Cursor & font
        "org/gnome/desktop/interface" = {
          # cursor-theme = "Catppuccin-${cat-flavour}-${cat-accent}-Cursors";
          font-name = "${user-font} ${user-font-size}";
          monospace-font-name = "${user-font} Mono ${user-font-size}";
        };

        # Theme
        # "org/gnome/shell/extensions/user-theme" = {
        #   name = "catppuccin-${cat-flavour}-${cat-accent}-standard";
        # };

        # GNOME shell settings
        "org/gnome/shell" = {
          # Theme
          color-scheme = "prefer-dark";
          # gtk-theme = "Catppuccin-Mocha-Standard-Lavender-Dark";
          # Extensions
          disable-user-extensions = false;
          # `gnome-extensions list` for a list
          enabled-extensions = [
            "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
            "blur-my-shell@aunetx"
            "dash-to-dock@micxgx.gmail.com"
            "gsconnect@andyholmes.github.io"
            "iso8601ish@S410"
            "just-perfection-desktop@just-perfection"
            "mprisLabel@moon-0xff.github.com"
            # "openbar@neuromorph"
            "trayIconsReloaded@selfmade.pl"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
        };
      };

    home.packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      dash-to-dock
      gsconnect
      iso8601-ish-clock
      just-perfection
      mpris-label
      # open-bar # Permission issues with the style.css
      tray-icons-reloaded
      user-themes
      # wintile-windows-10-window-tiling-for-gnome # incompatible version
    ];
    # ]) ++ (with pkgs; [
    #   nerdfonts
    # ]);
    # (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  };
}
