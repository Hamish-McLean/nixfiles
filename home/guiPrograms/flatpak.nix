{
  config,
  lib,
  ...
}:
{
  options = {
    flatpak.enable = lib.mkEnableOption "enables flatpak";
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak = {
      enable = true;
      packages = [
        "app.zen_browser.zen" # Zen browser
        "com.github.tchx84.Flatseal" # Flatseal flatpak manager
        "com.play0ad.zeroad" # 0 A.D.
      ];
    };
  };
}
