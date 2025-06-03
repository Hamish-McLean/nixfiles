/*
  Cycad's home manager module for Lenny.
  This imports Cycad's default home manager module which imports the other modules.
  Modules can be enabled or disabled here.
*/
{
  pkgs,
  ...
}:
{
  imports = [
    ../default.nix
    ../cliPrograms
    ../guiPrograms
  ];

  # Enable all cliPrograms modules
  cliPrograms.enable = true;

  # Enable all guiPrograms modules
  guiPrograms.enable = true;

  # Custom options
  hyprland.enable = true;
  rbw.enable = true; # Bitwarden CLI

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  # Extra programs
  home.packages = with pkgs; [
    gimp
    inkscape
    dwarf-fortress-packages.dwarf-fortress-full
  ];
}
