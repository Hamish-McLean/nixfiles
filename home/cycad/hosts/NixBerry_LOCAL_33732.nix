/*
Cycad's home manager module for NixBerry.
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

  # Disable specific modules

}