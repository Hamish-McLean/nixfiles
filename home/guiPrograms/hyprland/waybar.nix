/*
  catppuccin waybar example at
  https://github.com/rubyowo/dotfiles/tree/f925cf8e3461420a21b6dc8b8ad1190107b0cc56/config/waybar
*/
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    waybar.enable = lib.mkEnableOption "enables waybar";
  };
  config = lib.mkIf config.waybar.enable {
    home.packages = [ pkgs.waybar ];
    catppuccin.waybar.enable = true;
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [
        {
          layer = "top"; # or bottom
          position = "top"; # or bottom
          margin = "4px";
          # height = 30;
          # width = 1280;
          # spacing = 4;
          # output = [
          #   "eDP-1"
          #   "HDMI-A-2"
          # ];
          modules-left = [
            "custom/rofi"
            "hyprland/workspaces"
            # "wlr/taskbar"
            # "hyprland/window"
          ];
          modules-center = [
            "custom/music"
            # "mpris"
          ];
          modules-right = [
            "tray"
            "wireplumber"
            "backlight"
            "battery"
            "bluetooth"
            "network"
            "clock"
            # "custom/lock"
            "custom/power"
            # "battery#bat0" # Fix battery name if needed
          ];
          "custom/rofi" = {
            format = " ";
            on-click = "rofi -show drun";
          };
          "hyprland/workspaces" = {
            format = "{icon}";
            fromat-icons = {
              default = " ";
            };
          };
          "wlr/taskbar" = {
            on-click = "activate";
            icon-size = 20;
          };
          "custom/music" = {
            format = "  {}";
            escape = true;
            interval = 5;
            tooltip = false;
            exec = "playerctl metadata --format='{{ title }}'";
            on-click = "playerctl play-pause";
            max-length = 50;
          };
          tray = {
            icon-size = 20;
            spacing = 10;
          };
          wireplumber = {
            # scroll-step = 1,; # %, can be a float
            format = "{icon}";
            tooltip-format = "{node_name} {volume}%";
            format-muted = " ";
            format-icons = [
              " "
              " "
              " "
            ];
            on-click = "pavucontrol";
            on-click-right = "qpwgraph";
          };
          backlight = {
            # device = "intel_backlight";
            format = "{icon}";
            tooltip-format = "{percent}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
            interval = 2;
            on-scroll-up = "brightnessctl set 5%+";
            on-scroll-down = "brightnessctl set 5%-";
          };
          battery = {
            states = {
              good = 80;
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            tooltip-format = "{capacity}%";
            format-icons = [
              "󰂃"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            format-charging = "{icon}󱐋";
            format-full = "󱟢 ";
            on-click = "rofi-power-profiles"; # -location 3";
          };
          clock = {
            timezone = "Europe/London";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
            format = "{:%H:%M}";
          };
          "custom/lock" = {
            tooltip = false;
            # on-click = "sh -c '(sleep 0.5s; swaylock --grace 0)' & disown";
            format = " ";
          };
          "custom/power" = {
            tooltip = false;
            on-click = "rofi -show p -modi p:'rofi-power-menu' -location 3 -theme-str 'window {width: 11em; height: 14em;} inputbar {enabled: false;}'";
            format = "⏻ ";
          };
          network = {
            format-wifi = "{icon}";
            format-icons = {
              wifi = [
                "󰤟 "
                "󰤢 "
                "󰤥 "
                "󰤨 "
              ];
            };
            format-disconnected = "󰤮 ";
            format-ethernet = "󰈁";
            tooltip-format = "{essid}";
            on-click = "ronema"; # -location 3";
          };
          bluetooth = {
            format-connected = "󰂰";
            format-on = "󰂯";
            format-off = "󰂲";
            on-click = "rofi-bluetooth"; # -location 3 -xoffset -100 -yoffset 50"; # -theme-str 'window {width: 50%;}'"; #listview {lines: 6;}'";
            tooltip-format-connected = "{device_enumerate}";
            tooltip-device-enumerate-connected = "{device_alias}";
          };
        }
      ];
      style = builtins.readFile ./waybar.css;
    };
  };
}
