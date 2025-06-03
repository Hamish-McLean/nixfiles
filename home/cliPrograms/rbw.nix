/*
  rbw Bitwarden cli client

  https://github.com/doy/rbw

  Needs to be authenticated with an API key using `rbw register`
*/
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    rbw.enable = lib.mkEnableOption "enables rbw";
  };

  config = lib.mkIf config.rbw.enable {
    programs.rbw = {
      enable = true;
      settings = {
        base_url = "https://api.bitwarden.com";
        email = "HamishMcLean94@gmail.com";
        pinentry = pkgs.pinentry-tty;
      };
    };
  };
}
