{ config, lib, ... }:

with lib;
let cfg = config.hyprmodules;
in {
  config = mkIf cfg.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd =
            if cfg.hyprlock.enable then "pidof hyprlock || hyprlock" else "";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listeners = [
          {
            timeout = 150; # 2.5min.
            on-timeout = "brightnessctl -s set 2%";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 150; # 2.5min.
            on-timeout =
              "brightnessctl -q --device=platform::kbd_backlight get | awk '{if ($1 >= 1) system(\"brightnessctl -sd platform::kbd_backlight set 0\")}'";
            on-resume = "brightnessctl -rd platform::kbd_backlight";
          }
          {
            timeout = 900; # 5min
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 1200; # 5.5min
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on; brightnessctl -r";
          }
          {
            timeout = 1800; # 30min
            on-timeout = "systemctl suspend";
          }
        ];

      };
    };
  };
  options.hyprmodules.hypridle.enable = mkEnableOption "Enable hypridle";
}
