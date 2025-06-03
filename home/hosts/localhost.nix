/*
  Home manager module for nix-on-droid.
  This imports Cycad's default home manager module which imports the other modules.
  Modules can be enabled or disabled here.
*/
{
  username,
  pkgs,
  ...
}:
{
  imports = [
    ../cliPrograms
  ];

  # Enable all cliPrograms modules
  cliPrograms.enable = true;

  # Disable specific modules
  bash.enable = false;

  home.stateVersion = "24.05";
  home = {
    username = username;
    homeDirectory = /data/data/com.termux.nix/files/home;
  };
  # Fonts
  # home.packages = with pkgs; [
    # (nerdfonts.override {
    #   fonts = [
    #     "FiraCode"
    #     "JetBrainsMono"
    #   ];
    # })
  # ];

  home.packages = with pkgs.nerd-fonts; [
    fira-code
    jetbrains-mono
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "JetBrainsMono" ];
      monospace = [ "JetBrainsMono" ];
      sansSerif = [ "JetBrainsMono" ];
      serif = [ "JetBrainsMono" ];
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "sapphire";
  };

}
