{
  config,
  lib,
  ...
}:
{
  options = {
    hypridle.enable = lib.mkEnableOption "enables hypridle";
  };

  config = lib.mkIf config.hypridle.enable {
    
    services.hypridle = {

      enable = true;

      settings.general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # Command to lock the session
        before_sleep_cmd = "loginctl lock-session"; # Sleep command. `loginctl lock-session` notifies other applications
        after_sleep_cmd = "hyprctl dispatch dpms on"; # Wake command
        inhibit_sleep = 2; # 1 ?, 2 auto, 3 wait until lock
      };

      settings.listener = [

        # Screen off after 20 seconds
        {
          timeout = 10 * 60; # in seconds
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on"; # Turn screen on when activity resumes
        }

        # Lock after 30 seconds
        {
          timeout = 20 * 60; # in seconds
          on-timeout = "pidof hyprlock || hyprlock"; # Lock session
        }

        # Sleep after 60 seconds (30 seconds after lock)
        {
          timeout = 60 * 60; # in seconds
          on-timeout = "systemctl suspend"; # Command to put the system to sleep
        }
      ];
    };
  };
}
