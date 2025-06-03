{
  config,
  lib,
  ...
}:
{
  options = {
    starship.enable = lib.mkEnableOption "enables starship";
  };
  config = lib.mkIf config.starship.enable {
    programs.starship = {

      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;

      settings = {
        add_newline = true;
        format = "$os$all";

        os = {
          symbols.NixOS = "  ";
          style = "sapphire";
          disabled = false;
        };
        nix_shell = {
          format = "(via [$symbol$state]($style) [\($name\)]($style) )"; # "via [$symbol$state( \($name\))]($style) "
          symbol = "󱄅 ";
          heuristic = true;
        };
        direnv.disabled = false;
        shell = {
          bash_indicator = " ";
          fish_indicator = "󰈺 "; #    󰈺
          disabled = false;
        };
      };

    };

    catppuccin.starship.enable = true;
  };
}
