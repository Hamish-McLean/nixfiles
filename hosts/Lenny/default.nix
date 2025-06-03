# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  pkgs,
  system,
  username,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
    # ./lenny-fingerprint.nix
    ../common.nix
    ../../modules
    ../../users/cycad.nix
    ../../users/fallo.nix
  ];

  # Custom options
  gaming.enable = true;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.plymouth.enable = true;

  networking = {
    hostName = "Lenny"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Enable networking
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true; depracated?
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.dbus.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Desktop environments
  sddm.enable = true;
  cosmic.enable = false;
  gnome.enable = true;
  hyprland.enable = true;
  kde.enable = false;
  qt_config.enable = false;

  services.tailscale.enable = true;

  # Flatpaks
  services.flatpak.enable = true;

  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox;
      nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
    };
    fish.enable = true;
  };

  # Android
  programs.adb.enable = true;
  users.users.cycad.extraGroups = ["adbusers"];

  virtualisation.waydroid.enable = true;

  environment.systemPackages = with pkgs; [
    firefoxpwa
    playerctl
    plymouth # Boot screen with catppuccin themes
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.cycad = {
  #   isNormalUser = true;
  #   description = "Hamish McLean";
  #   extraGroups = [
  #     "input"
  #     "networkmanager"
  #     "wheel"
  #   ];
  #   shell = pkgs.fish;
  # };
  users.users.cycad.packages = (
    with pkgs; [
      bitwarden
      firefox
      fractal
      gtop
      libreoffice
      # modrinth-app
      mumble
      obsidian
      oh-my-git
      stremio
      syncthing
      telegram-desktop
      warp-terminal
      whatsapp-for-linux
    ]
  );

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
