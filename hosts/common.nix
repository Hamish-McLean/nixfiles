{
  pkgs,
  system,
  lib,
  inputs,
  ...
}:
{

  time.timeZone = "Europe/London";

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

  environment.systemPackages = (
    with pkgs;
    [
      btop
      curl
      ddgr
      du-dust
      fish
      gh # Github
      git
      github-copilot-cli
      # helix.packages."${pkgs.system}".helix
      htop
      nano
      fastfetch
      neovim
      nh # Nix helper
      nixd
      nixfmt-rfc-style
      nmap
      onefetch
      pet
      tldr
      tmux
      tree
      wget
    ]
  );

}
