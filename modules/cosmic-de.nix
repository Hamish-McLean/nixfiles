{ config, lib, cosmic, ... }:
{
  imports = [
    cosmic.nixosModules.default
  ];

  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;

}