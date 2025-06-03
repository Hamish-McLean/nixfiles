# Cycad's default home manager module which imports other home manager modules
{
  pkgs,
  username,
  # inputs,
  ...
}:
{
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [
    # ./cliPrograms # These are now imported in host
    # ./guiPrograms
    # inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "sapphire";
  };

  home = {
    username = username;
    homeDirectory = /home/${username};
  };

  # Fonts
  home.packages = with pkgs.nerd-fonts; [
    code-new-roman
    droid-sans-mono
    fantasque-sans-mono
    fira-code
    fira-mono
    jetbrains-mono
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "JetBrainsMono Nerd Font" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "JetBrainsMono Nerd Font" ];
      serif = [ "JetBrainsMono Nerd Font" ];
    };
    # defaultFonts = {
    #   emoji = [ "jetbrains-mono" ];
    #   monospace = [ "jetbrains-mono" ];
    #   sansSerif = [ "jetbrains-mono" ];
    #   serif = [ "jetbrains-mono" ];
    # };
  };

  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    defaultSopsFile = secrets/secrets.yaml;
  };

  xdg.enable = true;
}
