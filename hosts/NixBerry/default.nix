{
  # config,
  inputs,
  pkgs,
  # lib,
  ...
}:

{
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
    ../common.nix
    ../../users/cycad.nix
    inputs.vscode-server.nixosModules.default
    inputs.vscodium-server.nixosModules.default
  ];

  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    kernelParams = [ "brcmfmac.feature_disable=0x82000" ];
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true; # What does this do?
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  networking = {
    hostName = "NixBerry";
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;
      #wifi.backend = "iwd";
      #wifi.country = "GB";
      settings.wifi.country = "GB";
    };
  };

  programs.fish.enable = true;

  services.openssh.enable = true;

  services.tailscale.enable = true;

  # VSCode
  services.vscode-server.enable = true;
  services.vscodium-server.enable = true;

  virtualisation.docker.enable = true; # Docker running as root

#  users.users.cycad = {
#    isNormalUser = true;
#    description = "Hamish McLean";
#    extraGroups = [
#      "docker"
#      "networkmanager"
#      "wheel"
#    ];
#    shell = pkgs.fish;
#  };

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}
