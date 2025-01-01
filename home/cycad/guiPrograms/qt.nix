{ 
  config, 
  lib, 
  pkgs,
  ... 
}:
{
  options = {
    qt_config.enable = lib.mkEnableOption "enables qt";
  };

  config = lib.mkIf config.qt_config.enable {
    home.packages = with pkgs; [
      # (catppuccin-kvantum.override {
      #   variant = "mocha";
      #   accent = "sapphire";
      # })
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      # catppuccin-cursors.mochaSapphire
    ];
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };
    environment.variables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };
    catppuccin.kvantum = {
      enable = true;
      apply = true;
    };
  };
}
