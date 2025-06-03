{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    vscodium.enable = lib.mkEnableOption "enables vscodium";
  };
  config = lib.mkIf config.vscodium.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
        tailscale.vscode-tailscale
      ];
    };
  };
}
