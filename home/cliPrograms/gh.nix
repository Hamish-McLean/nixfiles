{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    gh.enable = lib.mkEnableOption "enables gh";
  };

  config = lib.mkIf config.gh.enable {
    programs.gh = {
      enable = true;
      extensions = with pkgs; [
        gh-dash
      ]; # https://github.com/topics/gh-extension
    };
  };
}
