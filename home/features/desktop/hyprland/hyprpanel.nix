{ config, lib, inputs,
# pkgs,
... }:

with lib;
let
  # aplay = getExe' pkgs.alsa-utils "aplay";
  cfg = config.hyprmodules.hyprpanel;
  # sounds = "~/Music/sounds";
  # l_sound = "${sounds}/logout.wav"; # TODO: get assets
  # s_sound = "${sounds}/shutdown.wav";
in {
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  config = mkIf cfg.enable {
    programs.hyprpanel = {
      enable = true;
      hyprland.enable = true;
      overwrite.enable = true;
      overlay.enable = true;
      settings = {
        layout = {
          "bar.layouts" = {
            "*" = {
              "left" = [ "dashboard" "workspaces" "media" ];
              "middle" = [ "clock" ];
              "right" = [
                "volume"
                "battery"
                "network"
                "bluetooth"
                "systray"
                "notifications"
                "power"
              ];
            };
          };
        };

        bar = {
          bluetooth = { rightClick = "blueman-manager"; };

          clock = {
            format = "%I:%M %p | %a • %h | %dth";
            icon = "";
          };
          launcher.autoDetectIcon = true;

          media = {
            truncation_size = 25;
            rightClick = "playerctl play-pause";
            show_active_only = true;
          };

          network = {
            label = false;
            rightClick = "nm-connection-editor";
            showWifiInfo = true;
          };

          systray.ignore = [ "nm-applet" "blueman" ];

          volume = {
            rightClick = "pamixer -t";
            scrollUp = "pamixer -i 5";
            scrollDown = "pamixer -d 5";
          };

          workspaces = { workspaceIconMap = { "1" = ""; }; };
        };

        menus = {
          clock = { weather.enabled = false; };

          power = {
            lowBatteryNotification = true;
            # reboot = "${aplay} -c 2 ${s_sound}; sleep 2; systemctl reboot";
            reboot = "systemctl reboot";
            # shutdown = "${aplay} -c 2 ${s_sound}; sleep 2; systemctl poweroff";
            shutdown = "systemctl poweroff";
            # logout = "${aplay} -c 2 ${l_sound}; sleep 2; uwsm stop";
            logout = "uwsm stop";
          };
        };

        theme = {
          bar = {
            transparent = true;
            floating = true;
            outer_spacing = "0em";
            margin_top = "0em";

            menus = {
              menu = {
                battery.scaling = 100;
                bluetooth.scaling = 100;
                clock.scaling = 80;
                dashboard = {
                  confirmation_scaling = 80;
                  scaling = 80;
                };
                media.scaling = 90;
                network.scaling = 90;
                notifications.scaling = 85;
                volume.scaling = 90;
              };
            };
          };

          font = {
            name = "JetBrains Mono Nerd Font";
            size = "1rem";
          };

          osd = {
            location = "bottom";
            margins = "0px 0px 0px 0px";
            muted_zero = true;
            orientation = "horizontal";
          };

          tooltip.scaling = 80;

        };

        scalingPriority = "hyprland";
      };
    };
  };
  options.hyprmodules.hyprpanel.enable = mkEnableOption "Enable hyprpanel";
}
