/*
  Cycad's default cliPrograms home manager module.
  This imports other cliPrograms home manager modules.
  All can be enabled by setting cliPrograms = true.
  Modules are enabled by default so can be disabled by setting them to false.
*/
{
  lib,
  config,
  pkgs,
  ...
}:
{
  # Cli programs to import
  imports = [
    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./bottom.nix
    ./btop.nix
    ./carapace.nix
    ./cava.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./gh.nix
    ./gh-dash.nix
    ./git.nix
    ./gitui.nix
    # ./helix.nix
    ./lazygit.nix
    # ./nh.nix
    ./nixvim-config.nix
    ./nushell.nix
    ./nvf.nix
    ./pandoc.nix
    ./rbw.nix
    ./skim.nix
    ./spotify-player.nix
    ./starship.nix
    ./thefuck.nix
    ./tmux.nix
    ./yazi.nix
    ./zellij.nix
    ./zoxide.nix
  ];

  # Option to enable all cliPrograms modules
  options = {
    cliPrograms.enable = lib.mkEnableOption "enables cliPrograms";
  };
  config = lib.mkIf config.cliPrograms.enable {

    home.packages = with pkgs; [
      cfspeedtest
      ddgr
      du-dust
      github-copilot-cli
      imagemagick
      prettyping
      progress
    ];

    # Custom options
    atuin.enable = lib.mkDefault true;
    bash.enable = lib.mkDefault true;
    bat.enable = lib.mkDefault true;
    bottom.enable = lib.mkDefault true;
    btop.enable = lib.mkDefault true;
    carapace.enable = lib.mkDefault true;
    cava.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true; # Only in home-manager unstable
    fish.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    gh.enable = lib.mkDefault true;
    # gh-dash.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    gitui.enable = lib.mkDefault true;
    # helix.enable = lib.mkDefault true;
    lazygit.enable = lib.mkDefault true;
    # nh.enable = lib.mkDefault true;
    nixvim-config.enable = lib.mkDefault false;
    nushell.enable = lib.mkDefault true;
    nvf.enable = lib.mkDefault true;
    pandoc.enable = lib.mkDefault true;
    skim.enable = lib.mkDefault true;
    spotify-player.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    thefuck.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    yazi.enable = lib.mkDefault true;
    zellij.enable = lib.mkDefault false;
    zoxide.enable = lib.mkDefault true;
  };

}
