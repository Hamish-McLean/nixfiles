/*
  Home manager module for kde plasma.
  https://github.com/nix-community/plasma-manager/blob/trunk/examples/home.nix
*/
{
  config,
  lib,
  pkgs,
  # plasma-manager,
  ...
}:
{
  # imports = [
  #   plasma-manager.homeManagerModules.plasma-manager
  # ];

  options = {
    plasma.enable = lib.mkEnableOption "enables plasma";
  };

  config = lib.mkIf config.plasma.enable {

    programs.plasma =
      let
        wallpaper = pkgs.fetchurl {
          url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/misc/rainbow.png";
          hash = "sha256-6uYCbzefvkXF1JBtSMkYPJhH60GIHhhAkO60UzlQ/U0=";
        };
      in
      {
        enable = true;
        workspace = {
          cursor = {
            theme = "Catppuccin-Mocha-Sapphire";
            size = lib.mkDefault 32;
          };
          # iconTheme = "Papirus-Dark";
          wallpaper = "${wallpaper}";
        };
        panels = [
          {
            location = "bottom";
            hiding = "autohide";
            widgets = [
              # Application icons on the panel
              {
                iconTasks.launchers = [
                  "applications:firefox.desktop"
                  "applications:codium.desktop"
                ];
              }
              {
                digitalClock = {
                  calendar.firstDayOfWeek = "monday";
                  time.format = "24h";
                };
              }
              {
                systemTray.items = {
                  shown = [
                    "org.kde.plasma.battery"
                    "org.kde.plasma.bluetooth"
                  ];
                  hidden = [
                    "org.kde.plasma.brightness"
                  ];
                };
              }
            ];
          }
        ];
      };

    home.packages = with pkgs; [
      # (catppuccin-kvantum.override {
      #   variant = "mocha";
      #   accent = "sapphire";
      # })
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      # catppuccin-cursors.mochaSapphire
    ];

    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };

    # catppuccin.kvantum = {
    #   enable = true;
    #   apply = true;
    # };

    # xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    #   General.theme = "Catppuccin-Mocha-Sapphire";
    # };

    xdg.configFile =
      let
        variant = "mocha";
        accent = "sapphire";
        kvantumThemePackage = pkgs.catppuccin-kvantum.override {
          inherit variant accent;
        };
      in
      {
        "Kvantum/kvantum.kvconfig".text = ''
          [General]
          theme=Catppuccin-${variant}-${accent}
        '';

        # The important bit is here, links the theme directory from the package to a directory under `~/.config`
        # where Kvantum should find it.
        "Kvantum/Catppuccin-${variant}-${accent}".source =
          "${kvantumThemePackage}/share/Kvantum/Catppuccin-${variant}-${accent}";
      };
  };
}
