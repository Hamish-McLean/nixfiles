{
  config,
  lib,
  ...
}:
{
  options = {
    nushell.enable = lib.mkEnableOption "enables nushell";
  };

  config = lib.mkIf config.nushell.enable {
    programs.nushell = {
      enable = true;
      configFile.text = ''
        $env.config.show_banner = false
      '';
      shellAliases = {
        pping = "prettyping --nolegend";
        speedtest = "cfspeedtest";
      };
    };
    # catppuccin.nushell.enable = true;
  };
}
