{
  config,
  lib,
  username,
  ...
}:
let
  accent = "rgb(74c7ec)";
  base = "rgb(1e1e2e)";
  green = "rgb(a6e3a1)";
  red = "rgb(f38ba8)";
  surface0 = "rgb(313244)";
  text = "rgb(cdd6f4)";
in
{
  options = {
    hyprlock.enable = lib.mkEnableOption "enables hyprlock";
  };

  config = lib.mkIf config.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings.background.path = "${../../wallpapers/minimalist-black-hole.png}";
      # settings = {
      #   background = {
      #     path = "${../../wallpapers/rainbow.png}";
      #   };
      #   shape = {
      #     size = "400, 200";
      #     color = base;
      #     rounding = 12;
      #     border_size = 2;
      #     border_color = accent;
      #     position = "0, 80";
      #     halign = "center";
      #     valign = "center";
      #   };
      #   input-field = {
      #     size = "200 50";
      #     outline_thickness = 2;
      #     dots_size = 0.1;
      #     dots_spacing = 0.3;
      #     inner_color = surface0;
      #     outer_color = surface0;
      #     check_color = green;
      #     fail_color = red;
      #     font_color = text;
      #     fade_on_empty = false;
      #     rounding = 12;
      #     position = "0, 50";
      #     halign = "center";
      #     valign = "center";
      #   };
      #   label = {
      #     # Greeting
      #     text = "Welcome, ${username}";
      #     color = accent;
      #     font_size = 20;
      #     position = "0, 100";
      #     halign = "center";
      #     valign = "center";
      #   };
      #   # label = { # Lock icon
      #   #   text = " ";
      #   #   color = accent;
      #   # };
      # };
    };
    catppuccin.hyprlock.enable = true;
  };
}
