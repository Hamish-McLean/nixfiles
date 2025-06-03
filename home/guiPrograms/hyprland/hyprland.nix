{
  config,
  # hyprland-plugins,
  inputs,
  lib,
  pkgs,
  system,
  # username,
  ...
}:
let
  accent = "rgb(74c7ec)";
  # base = "rgb(1e1e2e)";
  # green = "rgb(a6e3a1)";
  # red = "rgb(f38ba8)";
  surface0 = "rgb(313244)";
in
# text = "rgb(cdd6f4)";
{
  imports = [
    ./dunst.nix
    ./hyprland-virtual-desktops.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpanel.nix
    ./hyprpaper.nix
    ./rofi.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    # Hyprland cachix so hyprland and dependencies don't have to be compiled
    # https://wiki.hyprland.org/Nix/Cachix/
    # nix.settings = {
    #   substituters = ["https://hyprland.cachix.org"];
    #   trusted-substituters = ["https://hyprland.cachix.org"];
    #   trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    # };

    # Custom options

    # dunst.enable = true;
    # hyprland-virtual-desktops.enable = true;
    hypridle.enable = true;
    hyprlock.enable = true;
    hyprpanel.enable = true;
    hyprpaper.enable = true;
    rofi.enable = true;
    # waybar.enable = true;
    wlogout.enable = true;

    catppuccin.hyprland.enable = true;

    home.packages = with pkgs; [
      brightnessctl
      # hyprcursor
      hyprsunset
      networkmanagerapplet
      pavucontrol
    ];

    home.pointerCursor.hyprcursor = {
      enable = true;
      size = lib.mkForce 30;
    };
    home.sessionVariables.HYPRCURSOR_SIZE = lib.mkForce 30;

    wayland.windowManager.hyprland = {

      enable = true;
      # package = inputs.hyprland.packages.${system}.hyprland;
      # package = inputs.hyprland.packages.${system}.hyprland; # ${pkgs.stdenv.hostPlatform.system}
      # portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
      systemd.enable = true;
      # plugins = with inputs.hyprland-plugins.packages."${system}"; [
      # plugins = with inputs.hyprland-plugins.packages.${system}; [
      plugins = with pkgs.hyprlandPlugins; [
        # borders-plus-plus
        hyprspace
        # hyprtrails
      ];

      settings = {

        monitor = [
          "HDMI-A-2,preferred,0x0,1" # Scaling for external monitor
          "eDP-1,preferred,auto,1" # Scaling for laptop screen
        ];

        input = {
          kb_layout = "gb";
          touchpad.natural_scroll = true;
          touchpad.tap-to-click = true;
          sensitivity = 0.5; # -1.0 ≤ x ≤ 1.0
        };

        general = {
          border_size = 1;
          "col.active_border" = accent;
          "col.inactive_border" = surface0;
          gaps_in = 5;
          gaps_out = 10;
          resize_on_border = true;
          snap.enabled = true;
        };

        decoration = {
          rounding = 12;
          active_opacity = 1;
          inactive_opacity = 0.9;
          blur = {
            enabled = true;
            size = 16;
            passes = 2;
            ignore_opacity = true;
          };
          shadow = {
            enabled = true;
            range = 5;
            render_power = 1000;
            color = accent;
            color_inactive = "rgba(00000000)";
          };
        };

        gestures.workspace_swipe = "true";

        # Plugins

        plugin = {
          # borders-plus-plus = {
          #   add_borders = 0;
          #   natural_rounding = "yes";
          # };
          # hyprspace # nix instruction at "https://github.com/KZDKM/Hyprspace"
          # hyprtrails.color = accent;
        };

        # Hyprspace
        "plugin:overview:autodrag" = true; # Drag windows between workspaces
        "plugin:overview:autoScroll" = true; # Scroll on the panel to pan workspaces
        "plugin:overview:exitOnClick" = true; # Click without dragging to exit
        "plugin:overview:exitOnSwitch" = true; # Exit overview when switching workspaces
        "plugin:overview:showNewWorkspace" = true; # Show an empty workspace for new ones
        "plugin:overview:centerAligned" = true; # KDE/macOS style centering
        # Styling options
        "plugin:overview:workspaceBorderColor" = "#74c7ec"; # "rgba(ee4b55ff)";
        "plugin:overview:workspaceBorderThickness" = 4;
        "plugin:overview:panelBackground" = "#1e1e2e"; # "rgba(1a1a1aee)"; # Panel background color with alpha
        "plugin:overview:panelPadding" = 10;
        "plugin:overview:padding" = 5; # Padding around workspaces
        "plugin:overview:gap" = 5; # Gap between workspaces
        "plugin:overview:reverseSwipe" = false; # Reverse touchpad swipe direction
        # Blacklist specific workspaces from showing in the overview
        # "plugin:overview:blacklistedWorkspaces" = [ "special" "10" ]; # Example

        # keybinds

        "$mod" = "SUPER";
        bind =
          [
            # "$mod, exec, rofi -show drun, release"
            "$mod, SPACE, exec, rofi -show drun"
            "$mod, TAB, exec, hyprctl dispatch overview:toggle"
            "$mod, C, killactive"
            "$mod, E, exec, nautilus"
            "$mod, F, exec, firefox"
            "$mod, K, exec, kitty"
            "$mod, L, exec, pidof hyprlock || hyprlock"
            "$mod, M, exit"
            "$mod, R, exec, hyprctl reload"
            "$mod, V, exec, codium"
            ", Print, exec, grimblast copy area"

            # Windows
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"
            "$mod CTRL, left, movewindow, l"
            "$mod CTRL, right, movewindow, r"
            "$mod CTRL, up, movewindow, u"
            "$mod CTRL, down, movewindow, d"
            "$mod SHIFT, left, movetoworkspace, -1"
            "$mod SHIFT, right, movetoworkspace, +1"
            "$mod, COMMA, togglesplit"
            "$mod, PERIOD, togglefloating"

            # Workspaces
            # "$mod, tab, workspace, e+1"
            # "$mod SHIFT, tab, workspace, e-1"
            "$mod, mouse_up, workspace, e+1"
            "$mod, mouse_down, workspace, e-1"

            # Media
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPrev, exec, playerctl previous"
            ", XF86audiostop, exec, playerctl stop"

            # Volume
            # ", 115, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            # ", 114, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            # ", 113, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

            # Brightness
            ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
            ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
            # ", xf86KbdBrightnessUp, exec, brightnessctl -d *::kbd_backlight set 33%+"
            # ", xf86KbdBrightnessDown, exec, brightnessctl -d *::kbd_backlight set 33%-"
            # ", XF86Keyboard, exec, brightnessctl -d tpacpi::kbd_backlight set 1+%"
            ", XF86Keyboard, exec, ${config.home.homeDirectory}/.config/hypr/scripts/cycle-kbd-backlight.sh" # Script defined later

          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (
              builtins.genList (
                x:
                let
                  ws =
                    let
                      c = (x + 1) / 10;
                    in
                    builtins.toString (x + 1 - (c * 10));
                in
                [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              ) 10
            )

          );
        # Mouse binds. LMB -> 272, RMB -> 273.
        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        bindr = [
          "$mod, SUPER_L, exec, killall rofi || rofi -show drun"
        ];

      };
    };

    # Scripts
    # keyboard backlight
    home.file.".config/hypr/scripts/cycle-kbd-backlight.sh" = {
      text = ''
        #!/usr/bin/env bash
        current=$(brightnessctl -d tpacpi::kbd_backlight get)
        max=2
        next=$(( (current + 1) % (max + 1) ))
        brightnessctl -d tpacpi::kbd_backlight set $next
      '';
      executable = true;  # Make the script executable
    };
  };
}
