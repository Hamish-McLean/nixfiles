/*
  Spicetify-Nix

  https://github.com/Gerg-L/spicetify-nix
*/
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options = {
    spicetify.enable = lib.mkEnableOption "enables spicetify";
  };

  config = lib.mkIf config.spicetify.enable {
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          # adblock
          featureShuffle
          fullAppDisplay
          hidePodcasts
          history
          playNext
          powerBar
          shuffle # shuffle+ (special characters are sanitized out of extension names)
        ];
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };
  };
}
