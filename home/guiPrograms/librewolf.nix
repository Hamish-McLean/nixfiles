{
  config,
  lib,
  ...
}:
{
  options = {
    librewolf.enable = lib.mkEnableOption "enables librewolf";
  };

  config = lib.mkIf config.librewolf.enable {
    programs.librewolf = {
      enable = true;
    };
  };
}
