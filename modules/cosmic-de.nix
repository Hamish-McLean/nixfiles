{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.cosmic.nixosModules.default
  ];

  options = {
    cosmic.enable = lib.mkEnableOption "enables cosmic";
  };

  config = lib.mkIf config.cosmic.enable {

    nix.settings = {
      substituters = [ "https://cosmic.cachix.org/" ];
      trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
    };

    services.desktopManager.cosmic.enable = true;
    # services.displayManager.cosmic-greeter.enable = true;

    environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
    # security.pam.services.cosmic-greeter.enableGnomeKeyring = true;
  };

}
