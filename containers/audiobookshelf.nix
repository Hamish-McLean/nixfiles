{
  config,
  lib,
  ...
}:
{
  options.services.audiobookshelf.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable the Audiobookshelf service.";
  };

  config = lib.mkIf config.services.audiobookshelf.enable {

    # This is the dependency check. The build will fail with this message
    # if the condition (traefik-tailscale.enable) is not met.
    assertions = [{
      assertion = config.services.traefik-tailscale.enable;
      message = "The audiobookshelf module requires services.traefik-tailscale to be enabled.";
    }];

    # The container definition
    virtualisation.podman.containers.audiobookshelf = {
      image = "ghcr.io/advplyr/audiobookshelf:latest";
      volumes = [ "/data/audiobookshelf/config:/config" ];
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.audiobookshelf.rule" = "Host(`audiobooks.your-tailnet.ts.net`)";
        "traefik.http.routers.audiobookshelf.entrypoints" = "web";
        "traefik.http.services.audiobookshelf.loadbalancer.server.port" = "80";
      };
    };
  };
}
