{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    tmux.enable = lib.mkEnableOption "enables tmux";
  };

  config = lib.mkIf config.tmux.enable {

    programs.tmux = {

      enable = true;
      clock24 = true;
      historyLimit = 10000;
      # keyMode = "vi";
      mouse = true;
      shell = "${pkgs.fish}/bin/fish";

      plugins = with pkgs.tmuxPlugins; [
        # catppuccin
        cpu
        battery
        better-mouse-mode
      ];

      extraConfig = ''
        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_date_time}"
        set -g @catppuccin_window_status_style "rounded"
        set -g @catppuccin_pane_status_enabled "yes"
        set -g @catppuccin_pane_border_status "yes"
        set -g @catppuccin_window_flags "icon" # none, icon, or text
      '';
      # set -agF status-right "#{E:@catppuccin_status_cpu}"
      # set -agF status-right "#{E:@catppuccin_status_battery}"
      # set -g @catppuccin_date_time "%H:%M"
      # set -g @catppuccin_flavour 'mocha'
      # set -g @catppuccin_window_tabs_enabled on
    };

    catppuccin.tmux.enable = true;

  };
}
