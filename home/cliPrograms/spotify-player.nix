{
  config,
  lib,
  ...
}:
{
  options = {
    spotify-player.enable = lib.mkEnableOption "enables spotify-player";
  };

  config = lib.mkIf config.spotify-player.enable {
    programs.spotify-player = {
      enable = true;
      # actions = {};
      # settings = {};
    };
  };
}
