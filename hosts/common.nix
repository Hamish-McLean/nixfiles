{
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
{

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  time.timeZone = lib.mkDefault "Europe/London";
  i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";
  i18n.extraLocaleSettings.LC_TIME = lib.mkDefault "en_DK.UTF-8"; # ISO 8601 datetimes

  console.keyMap = "uk";

  nix = {
    # nixPath = [ "nixpkgs=${nixpkgs}" ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 60d";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/cycad/.config/sops/age/keys.txt";
    secrets = { };
  };

  environment.systemPackages = (
    with pkgs;
    [
      btop
      curl
      fish
      gh # Github
      git
      has
      htop
      nano
      fastfetch
      neovim
      nh # Nix helper
      nixd
      nixfmt-rfc-style
      # nixfmt-classic
      nmap
      nushell
      onefetch
      pet
      tldr
      tmux
      wget
    ]
  );

}
