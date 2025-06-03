/*
  Cycad's home manager module for Roger.
  This imports Cycad's default home manager module which imports the other modules.
  Modules can be enabled or disabled here.
*/
{ ... }:
{
  imports = [
    ../default.nix
    ../cliPrograms
  ];

  # Enable all cliPrograms modules
  cliPrograms.enable = true;

  # Disable specific modules

}
