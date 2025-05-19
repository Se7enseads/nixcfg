{ config, lib, ... }:

with lib;
let
  cfg = config.hyprmodules;
  inherit (cfg) hyprlock;
  inherit (cfg) hypridle;
in {
  config = mkIf hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = optionalString hyprlock.enable
            "pidof hyprlock || hyprlock"; # lock screen
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
          after_sleep_cmd =
            "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };

        listeners = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 150; # 2.5min.
            on-timeout = "brightnessctl -sd platform::kbd_backlight set 0";
            on-resume = "brightnessctl -rd platform::kbd_backlight";
          }
          {
            timeout = 300; # 5min
            on-timeout = optionalString hyprlock.enable "hyprlock";
          }
          {
            timeout = 330; # 5.5min
            on-timeout =
              "hyprctl dispatch dpms off"; # screen off when timeout has passed
            on-resume =
              "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
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
