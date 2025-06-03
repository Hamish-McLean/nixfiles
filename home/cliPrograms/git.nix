{ config, lib, ... }:
{
  options = {
    git.enable = lib.mkEnableOption "enables git";
  };
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userEmail = "HamishMcLean94@gmail.com";
      userName = "Hamish McLean";
      # diff-so-fancy.enable = true;
      delta.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    catppuccin.delta.enable = true;
  };
}
