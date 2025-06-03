/*
  HyprPanel

  Flake: https://github.com/Jas-SinghFSU/HyprPanel

  Configuration: https://hyprpanel.com/getting_started/installation.html#nixos-home-manager
*/
{
  config,
  lib,
  ...
}:
let
  # base = "#1e1e2e";
  # green = "#a6e3a1";
  # red = "#f38ba8";
  sapphire = "#74c7ec";
in
# surface0 = "#313244";
# text = "#cdd6f4";
{
  options = {
    hyprpanel.enable = lib.mkEnableOption "enables hyprpanel";
  };

  config = lib.mkIf config.hyprpanel.enable {
    programs.hyprpanel = {
      enable = true;
      hyprland.enable = true;
      overlay.enable = true;
      overwrite.enable = true; # Allows gui configuration to be overwritten by home-manager
      override = {
        # Can override specific colours etc
        # As of nixpkgs 25.05 the attribute set must be enclosed in a string to avoid conflicting with settings section
        "theme.bar.buttons.dashboard.icon" = sapphire;
          # background = surface0;
      };

      # Layout

      settings.layout = {
        # https://hyprpanel.com/configuration/panel.html
        "bar.layouts" = {
          "*" = {
            left = [
              "dashboard"
              "workspaces"
              "windowtitle"
            ];
            middle = [
              "cava"
              "media"
            ];
            right = [
              "volume"
              "network"
              "bluetooth"
              "battery"
              "systray"
              "clock"
              "notifications"
            ];
          };
        };
        # "1" = {
        #   left = [ "dashboard" "workspaces" "windowtitle" ];
        #   middle = [ "media" ];
        #   right = [ "volume" "clock" "notifications" ];
        # };
        # "2" = {
        #   left = [ "dashboard" "workspaces" "windowtitle" ];
        #   middle = [ "media" ];
        #   right = [ "volume" "clock" "notifications" ];
        # };
        "bar.systray" = {
          customIcons = {
            # 
            "[Ss]team" = {
              icon = " ";
            }; # 󰓓    
            "[Ss]potify*" = {
              icon = " ";
            }; # 󰓇
            "KDE*" = {
              icon = " ";
            }; # 󰬒  󰰉  󰰋
            "zap*" = {
              icon = " ";
            };
          };
        };
      };

      # Settings

      settings = {
        bar = {
          clock.format = "%a %Y-%m-%d %H:%M";
          customModules.cava.showIcon = false;
          launcher.autoDetectIcon = true; # icon = "";
          # workspaces.showApplicationIcons = true;
          # workspaces.show_icons = true;
          workspaces.show_numbered = true;
        };
        menus = {
          clock.time = {
            military = true;
            hideSeconds = true;
          };
          clock.weather = {
            key = "62a54738d47e4b4dad9203040251601"; # Use nix-sops to hide this
            location = "Tunbridge Wells";
            unit = "metric";
          };
          dashboard.shortcuts.left = {
            shortcut1 = {
              command = "codium";
              icon = "";
              tooltip = "Vscodium";
            };
            shortcut2 = {
              command = "firefox";
              icon = "󰈹";
              tooltip = "Firefox";
            };
            shortcut3 = {
              command = "kitty";
              icon = "󰄛";
              tooltip = "Kitty";
            };
          };
          dashboard.powermenu.avatar.image = "${../../wallpapers/astronaught.jpg}";
        };

        # Theme

        theme = {
          name = "catppuccin_mocha"; # catppuccin_mocha, catppuccin_mocha_split, catppuccin_mocha_vivid
          bar = {
            border_radius = "0.8em";
            buttons.radius = "0.8em";
            enableShadow = true;
            floating = true;
            margin_sides = "10px";
            margin_top = "10px";
          };
          font = {
            name = "JetBrainsMono Nerd Font";
            size = "1rem";
          };
        };
        wallpaper.image = "${../../wallpapers/minimalist-black-hole.png}";
      };
    };
  };
}
