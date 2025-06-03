{
  config,
  lib,
  ...
}:
{
  options = {
    hyprpaper.enable = lib.mkEnableOption "enables hyprpaper";
  };

  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper =
      let
        wallpaper = "${../../wallpapers/minimalist-black-hole.png}";
      in
      {
        enable = true;
        settings = {
          ipc = "true";
          splash = false;
          preload = [ "../../wallpapers/minimalist-black-hole.png" ];
          wallpaper = [ ",../../wallpapers/minimalist-black-hole.png" ];
        };
      };
  };
}