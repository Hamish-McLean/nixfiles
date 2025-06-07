{
  description = "System flake";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";
    # For Lenny's 06cb-009a fingerprint sensor
    lenny-fingerprint = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Packages
    catppuccin.url = "github:catppuccin/nix";
    # cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    # cosmic-manager = {
    #   url = "github:HeitorAugustoLN/cosmic-manager";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     # home-manager.follows = "home-manager";
    #   };
    # };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      # submodules = true;
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
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscodium-server.url = "github:unicap/nixos-vscodium-server";
    # zen-browser = {
    #   url = "github:MarceColl/zen-browser-flake";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:

    let
      nixosSystem =
        system: hostname: username:
        nixpkgs.lib.nixosSystem {
          # pkgs = pkgs;
          inherit system;
          specialArgs = {
            inherit inputs system hostname username;
            # customArgs = { inherit system hostname username; };
          };
          modules = [
            # Overlays
            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [
                # Overlay to make unstable packages available as `pkgs.unstable.<package>`
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true; # Allow unfree in unstable pkgs as well
                  };
                })
                inputs.hyprpanel.overlay
              ];
            }
            # Modules
            ./hosts/${hostname}
            ./hosts/common.nix

            # home-manager
            inputs.home-manager.nixosModules.home-manager {
              home-manager.users.${username} = 
                { config, pkgs, lib, inputs, system, hostname, username, ... }:
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  imports = [
                    # ./home
                    ./home/hosts/${hostname}.nix
                    # (import ./home/hosts/${hostname}.nix {
                    #   inherit system hostname username;
                    # })
                    # (import ./home/cliPrograms {
                    #   inherit config pkgs lib inputs system hostname username;
                    # })
                    # (import ./home/guiPrograms {
                    #   inherit config pkgs lib inputs system hostname username;
                    # })
                    inputs.catppuccin.homeModules.catppuccin
                    # inputs.cosmic-manager.homeManagerModules.cosmic-manager
                    # inputs.hyprland.homeManagerModules.default # Switched to nixpkgs version for now
                    inputs.hyprpanel.homeManagerModules.hyprpanel
                    inputs.nixcord.homeModules.nixcord
                    inputs.nixvim.homeManagerModules.nixvim
                    inputs.nix-flatpak.homeManagerModules.nix-flatpak
                    inputs.nvf.homeManagerModules.default
                    inputs.plasma-manager.homeManagerModules.plasma-manager
                    inputs.rofi-applets.homeManagerModules.default
                    inputs.sops-nix.homeManagerModules.sops
                    inputs.spicetify-nix.homeManagerModules.default
                  ];
                };
            }
          ];
        };

    in
    {
      nixosConfigurations = {
        # NixOS hosts
        Lenny = nixosSystem "x86_64-linux" "Lenny" "cycad";
        NixBerry = nixosSystem "aarch64-linux" "NixBerry" "cycad";

        # WSL hosts
        Roger = nixosSystem "x86_64-linux" "Roger" "cycad";
        EMR0148 = nixosSystem "x86_64-linux" "EMR0148" "cycad";
      };
    };
}
