{
  description = "home-manager flake";

  inputs = {

    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; # Update version
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05"; # Update version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Packages
    catppuccin.url = "github:catppuccin/nix";
    # cosmic-manager = {
    #   url = "github:HeitorAugustoLN/cosmic-manager";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     # home-manager.follows = "home-manager";
    #   };
    # };
    # helix = {
    #   url = "github:helix-editor/helix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprland = {
      url = "github:hyprwm/Hyprland"; # Switched to nixpkgs version for now
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-virtual-desktops = {
      url = "github:levnikmyskin/hyprland-virtual-desktops";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprland.follows = "hyprland";
    };
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05"; # Update version
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    rofi-applets = {
      url = "gitlab:Zhaith-Izaliel/rofi-applets";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      homeSystem =
        system: hostname: username:
        # let
        #   pkgs = import nixpkgs {
        #     inherit system;
        #     config.allowUnfree = true;
        #     overlays = [ inputs.hyprpanel.overlay ];
        #   };
        #   unstablePkgs = import nixpkgs-unstable {
        #     inherit system;
        #     config.allowUnfree = true;
        #   };
        # in
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit
              inputs
              # pkgs
              # unstablePkgs
              system
              hostname
              username
              ;
          };
          modules = [
            # Allow unfree packages
            {
              nixpkgs.config.allowUnfree = true;
              # Overlay to make unstable packages available as `pkgs.unstable.<package>`
              nixpkgs.overlays = [
                # This overlay adds an 'unstable' attribute to pkgs,
                # which contains packages from the nixpkgs-unstable input.
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true; # Allow unfree in unstable pkgs as well
                  };
                })
                inputs.hyprpanel.overlay
              ];
            }
            ./hosts/${hostname}.nix
            inputs.catppuccin.homeModules.catppuccin
            # inputs.cosmic-manager.homeManagerModules.cosmic-manager
            # inputs.hyprland.homeManagerModules.default # Switched to nixpkgs version for now
            inputs.hyprpanel.homeManagerModules.hyprpanel
            inputs.nixcord.homeModules.nixcord
            inputs.nixvim.homeManagerModules.nixvim
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
            inputs.plasma-manager.homeManagerModules.plasma-manager
            inputs.rofi-applets.homeManagerModules.default
            inputs.sops-nix.homeManagerModules.sops
            inputs.spicetify-nix.homeManagerModules.default
          ];
        };

    in
    {
      homeConfigurations = {
        # NixOS hosts
        "cycad@Lenny" = homeSystem "x86_64-linux" "Lenny" "cycad";
        "cycad@NixBerry" = homeSystem "aarch64-linux" "NixBerry" "cycad";

        # NixOS-WSL hosts
        "cycad@Roger" = homeSystem "x86_64-linux" "Roger" "cycad";

        # nix-on-droid hosts
        "nix-on-droid@localhost" = homeSystem "aarch64-linux" "localhost" "nix-on-droid"; # Username must be set to nix-on-droid
      };
    };
}
