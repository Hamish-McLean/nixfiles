{
  config,
  pkgs,
  lib,
  ...
}:

let
  # Define the static Traefik configuration here to keep the module self-contained
  traefikConfig = pkgs.writeText "traefik.yml" ''
    entryPoints:
      web:
        address: ":80"
    providers:
      podman:
        exposedByDefault: false
        endpoint: "unix:///var/run/docker.sock"
    api:
      dashboard: true
  '';
in
{
  options.traefik.enable = lib.mkEnableOption {
    default = true;
    description = "Enable the Traefik reverse proxy with a Tailscale sidecar.";
  };

  config = lib.mkIf config.services.traefik.enable {

    virtualisation.podman = {
      pods."proxy" = {};
      containers = {
        tailscale = {
          pod = "proxy";
          image = "tailscale/tailscale:latest";
          hostname = "nixos-proxy";
          extraOptions = [
            "--env=TS_STATE_DIR=/var/lib/tailscale"
            "--env=TS_AUTHKEY=${builtins.readFile /etc/nixos/secrets/ts.key}"
          ];
          volumes = [ "/dev/net/tun:/dev/net/tun" "/var/lib/tailscale:/var/lib/tailscale" ];
          security_opt = [ "system_caps=true" "cap_net_admin=true" "cap_net_raw=true" ];
        };

        traefik = {
          pod = "proxy";
          image = "docker.io/library/traefik:v3.0";
          ports = [ "80:80" ];
          volumes = [
            "/run/podman/podman.sock:/var/run/docker.sock:ro"
            "${traefikConfig}:/etc/traefik/traefik.yml:ro" # Mount the generated config
          ];
          labels = {
            "traefik.enable" = "true";
            "traefik.http.routers.traefik-dashboard.rule" = "Host(`traefik.your-tailnet.ts.net`)";
            "traefik.http.routers.traefik-dashboard.service" = "api@internal";
          };
        };
      };
    };
  };
}
