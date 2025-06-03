/*
  Cycad's home manager module for EMR0148.
  This imports Cycad's default home manager module which imports the other modules.
  Modules can be enabled or disabled here.
*/
{ ... }:
{
  imports = [
    ../default.nix
  ];

  # Enable all cliPrograms modules
  cliPrograms.enable = true;

  # Enable all guiPrograms modules
  guiPrograms.enable = false;

  # Disable specific modules

}
