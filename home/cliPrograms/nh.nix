# Nix Helper
{
  config,
  lib,
  ...
}:
{
  options = {
    nh.enable = lib.mkEnableOption "enables nh";
  };

  config = lib.mkIf config.nh.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };
  };
}
