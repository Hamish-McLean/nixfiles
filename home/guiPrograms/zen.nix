{
  config,
  inputs,
  lib,
  system,
  ...
}:
{
  options = {
    zen.enable = lib.mkEnableOption "enables zen";
  };

  config = lib.mkIf config.zen.enable {
    home.packages = [
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
