{
  ...
}:
{
  imports = [
    ./traefik.nix
  ];

  virtualisation.podman.enable = true;

  # Create a persistent volume for the Podman socket.
  # This allows the Traefik container to communicate with the Podman API.
  # systemd.tmpfiles.rules = [
  #   "d /run/podman 0755 root root -"
  # ];

  # Containers
  traefik.enable = true;
  audiobookshelf.enable = true;
}
