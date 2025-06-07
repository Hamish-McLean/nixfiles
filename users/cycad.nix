{
  pkgs,
  ...
}:
{
  config = {
    users.users.cycad = {
      isNormalUser = true;
      description = "Hamish McLean";
      extraGroups = [
        "adbusers"
        "docker"
        "input"
        "networkmanager"
        "wheel"
      ];
      linger = true; 
      shell = pkgs.nushell;
    };
  };
}
