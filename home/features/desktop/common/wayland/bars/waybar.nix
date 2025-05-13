{ config, lib, ... }:
with lib;
let cfg = config.waymodules.bars.waybar;

in {
  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
      settings = [{
        layer = "top";
        height = 40;
        modules-left =
          [ "custom/wallpaper" "hyprland/workspaces" "custom/media" ];
        modules-center = [
          "clock#time"
          "custom/separator"
          "clock#week"
          "custom/separator_dot"
          "clock#month"
          "custom/separator"
          "clock#calendar"
        ];
        modules-right =
          [ "pulseaudio" "battery" "temperature" "tray" "custom/exit" ];

        "hyprland/workspaces" = {
          on-click = "activate";
          active-only = false;
          all-outputs = true;
          show-special = true;
          persistent-workspaces = { "*" = 1; };
        };
        "custom/wallpaper" = {
          format = "";
          on-click = "waypaper"; # TODO: add options for waypaper
          tooltip = true;
          tooltip-format = "Change wallpaper";
        };
        # FIXME: this is not working
        "custom/exit" = {
          format = "";
          on-click = "~/.config/rofi/scripts/powermenu_t2"; # inactive
          tooltip = true;
          tooltip-format = "Power menu";
        };

        "tray" = {
          icon-size = 20;
          spacing = 10;
          show-passive-items = true;
        };

        "clock#week" = {
          format = "{:%A}";
          tooltip = false;
        };

        "clock#month" = {
          format = "{:%h}";
          tooltip = false;
        };

        "clock#time" = {
          format = "{:%I:%M %p}";
          tooltip = false;
        };
        "custom/separator" = {
          format = " | ";
          tooltip = false;
        };

        "custom/separator_dot" = {
          format = "•";
          tooltip = false;
        };

        "clock#calendar" = {
          format = "{:%d}th";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          actions = { "on-click-right" = "mode"; };
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#f4dbd6'><b>{}</b></span>";
              days = "<span color='#cad3f5'><b>{}</b></span>";
              weeks = "<span color='#c6a0f6'><b>W{}</b></span>";
              weekdays = "<span color='#a6da95'><b>{}</b></span>";
              today = "<span color='#8bd5ca'><b><u>{}</u></b></span>";
            };
          };
        };

        "network" = {
          format = "{ifname}";
          format-wifi = "{icon} {signalStrength}%";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-ethernet = "󰈀 {ipaddr}/{cidr}";
          format-linked = "󰈀 {ifname} (No IP)";
          format-disconnected = "󰤫 Disconnected";
          tooltip-format-disconnected =
            "<span color='#ed8796'>disconnected</span>";
          tooltip-format = "󰈁 {ifname} via {gwaddri}";
          tooltip-format-wifi = ''
            SSID= {essid}({signalStrength}%); {frequency} MHz
            IP= {ipaddr}'';
          tooltip-format-ethernet = "   {ifname} ({ipaddr}/{cidr})";
          on-click = "nmtui-connect";
        };

        "battery" = {
          states = {
            high = 90;
            upper-medium = 70;
            medium = 50;
            lower-medium = 30;
            low = 10;
          };
          format = "{icon} {capacity}%";
          format-charging = "󱐋 {icon} {capacity}%";
          format-plugged = "󰚥 {icon} {capacity}%";
          format-time = "{H} h {M} min";
          format-icons = [ "󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{timeTo}";
        };

        # TODO: enhance with multiple players
        "custom/media" = {
          format = "{icon}{}";
          return-type = "json";
          format-icons = {
            Playing = " ";
            Paused = " ";
          };
          max-length = 25;
          exec = ''
            playerctl -a metadata --format '{"text": "{{artist}} - {{markup_escape(title)}}", "tooltip": "{{playerName}} : {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F'';
          on-scroll-up = "playerctl position 3+";
          on-scroll-down = "playerctl position 3-";
          on-click = "playerctl play-pause";
        };

        "pulseaudio" = {
          states = {
            high = 90;
            upper-medium = 70;
            medium = 50;
            lower-medium = 30;
            low = 10;
          };
          tooltip-format = "{desc}";
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{icon} {volume}% {format_source}";
          format-bluetooth-muted = "󰝟 {volume}% {format_source}";
          format-muted = "󰝟 {volume}% {format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 ";
          format-icons = {
            headphone = "󰋋";
            hands-free = "";
            headset = "󰋎";
            phone = "󰄜";
            portable = "󰦧";
            car = "󰄋";
            speaker = "󰓃";
            hdmi = "󰡁";
            hifi = "󰋌";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          reverse-scrolling = true;
          reverse-mouse-scrolling = true;
          on-click-right = "pwvucontrol"; # TODO: get pwvucontrol
          on-click = "pamixer -t"; # TODO: get pamixer
        };

        "bluetooth" = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {device_alias}";
          format-connected-battery =
            "󰂱 {device_alias} (󰥉 {device_battery_percentage}%)";
          tooltip-format = ''
            {controller_alias}	{controller_address} ({status})

            {num_connections} connected'';
          tooltip-format-disabled = "bluetooth off";
          tooltip-format-connected = ''
            {num_connections} connected

            {device_enumerate}'';
          tooltip-format-enumerate-connected =
            "{device_alias}	{device_address}";
          tooltip-format-enumerate-connected-battery =
            "{device_alias}	{device_address}	({device_battery_percentage}%)";
          max-length = 35;
          on-click = "bluetoothctl power on";
          on-click-right = "blueman-manager"; # TODO: get blueman-manager
        };

        "temperature" = {
          tooltip = false;
          thermal-zone = 8;
          critical-threshold = 70;
          format = "{icon} {temperatureC} 󰔄 ";
          format-critical = "🔥{icon}{temperatureC}󰔄 ";
          format-icons = [ "" "" "" "" "" ];
          on-click = "auto-cpufreq-gtk"; # TODO: get auto-cpufreq-gtk
        };

        # FIXME: notifications
        "custom/notifications" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification =
              "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification =
              "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client"; # TODO: replace
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      }];
      style = ''

        /* -----------------------------------------------------
         * Import Pywal colors 
         * ----------------------------------------------------- */
        @import '../../.cache/wal/colors-waybar.css';

        @define-color backgroundlight @color5;
        @define-color backgrounddark @color11;
        @define-color workspacesbackground1 @color5;
        @define-color workspacesbackground2 @color11;
        @define-color bordercolor @color11;
        @define-color textcolor1 #FFFFFF;
        @define-color textcolor2 #FFFFFF;
        @define-color textcolor3 #FFFFFF;
        @define-color iconcolor #FFFFFF;

        /* -----------------------------------------------------
         * General 
         * ----------------------------------------------------- */


        * {
          font-family: "JetBrains Mono Nerd Font", "Fira Sans Semibold", "Font Awesome 6 Free", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          border: none;
          border-radius: 0px;
          font-weight: bolder;
        }

        window#waybar {
          background-color: rgba(0, 0, 0, 0.5);
          border-bottom: 0px solid #ffffff;
          color: var(--color13);
          background: transparent;
          transition-property: background-color;
          transition-duration: .5s;
          padding: 10px;
        }

        /* -----------------------------------------------------
         * Workspaces 
         * ----------------------------------------------------- */

        #workspaces {
          background: @workspacesbackground1;
          margin: 5px;
          padding: 0px 1px;
          border-radius: 15px;
          border: 0px;
          font-weight: bold;
          font-style: normal;
          opacity: 1.0;
          color: @textcolor1;
        }

        #workspaces button {
          padding: 0px 5px;
          margin: 4px 3px;
          border-radius: 15px;
          border: 0px;
          background-color: @workspacesbackground2;
          transition: all 0.3s ease-in-out;
          opacity: 0.4;
        }

        #workspaces button.active {
          background: @workspacesbackground2;
          border-radius: 15px;
          min-width: 40px;
          transition: all 0.3s ease-in-out;
          opacity: 1.0;
        }

        #workspaces button:hover {
          background: @workspacesbackground2;
          border-radius: 15px;
          opacity: 0.7;
        }

        /* -----------------------------------------------------
         * Tooltips
         * ----------------------------------------------------- */

        tooltip {
          border-radius: 10px;
          background-color: @backgroundlight;
          opacity: 0.8;
          padding: 20px;
          margin: 0px;
        }

        tooltip label {
          color: @textcolor2;
        }


        /* -----------------------------------------------------
         * Modules
         * ----------------------------------------------------- */

        /* .modules-left>widget:first-child>#workspaces {
          margin-left: 0;
        }

        .modules-right>widget:last-child>#workspaces {
          margin-right: 0;
        } */

        .modules-left {
          margin-left: 10px;
        }

        .modules-right {
          margin-right: 10px;
        }

        /* -----------------------------------------------------
         * Custom Modules
         * ----------------------------------------------------- */
        #custom-wallpaper {
          margin-right: 16px;
          font-size: 20px;
        }

        #custom-exit {
          margin: 5px;
          font-size: 16px;
          color: @textcolor1;
          border-radius: 15px;
        }

        #custom-exit:hover {
          color: #dc2f2f;
          transition: all 0.3s ease-in-out;
        }

        /* -----------------------------------------------------
         * Clock
         * ----------------------------------------------------- */

        #custom-separator {
          color: black;
        }

        #custom-separator_dot {
          color: black;
        }

        .modules-center {
          font-weight: bold;
          background-color: @backgrounddark;
          color: white;
          border-radius: 15px;
          padding: 0px 20px;
          margin: 5px;
        }

        /* -----------------------------------------------------
         * Pulseaudio
         * ----------------------------------------------------- */

        #pulseaudio {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 10px 0px 10px;
          margin: 5px;
          opacity: 0.8;
        }

        #pulseaudio.muted {
          background-color: @backgrounddark;
          color: @textcolor1;
        }

        /* -----------------------------------------------------
         * Battery
         * ----------------------------------------------------- */

        #battery {
          background-color: @backgroundlight;
          font-size: 16px;
          color: @textcolor2;
          border-radius: 15px;
          padding: 2px 15px 0px 10px;
          margin: 5px;
          opacity: 0.8;
        }

        #battery.charging,
        #battery.plugged {
          color: @textcolor2;
          background-color: green;
        }

        @keyframes blink {
          to {
            background-color: @backgroundlight;
            color: @textcolor2;
          }
        }

        #battery.low:not(.charging) {
          background-color: #f53c3c;
          color: @textcolor3;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        /* -----------------------------------------------------
         * Tray
         * ----------------------------------------------------- */

        #tray {
          padding: 0px 10px;
          background-color: @backgrounddark;
          margin: 5px;
          border-radius: 15px;
        }

        #tray>.passive {
          -gtk-icon-effect: dim;
        }

        #tray>.needs-attention {
          -gtk-icon-effect: highlight;
        }

        /* -----------------------------------------------------
         * Media
         * ----------------------------------------------------- */


        #custom-media {
          background-color: @backgrounddark;
          background-image: linear-gradient(62deg, @backgrounddark 0%, @backgroundlight 100%);
          font-weight: bold;
          color: white;
          border-radius: 20px;
          margin : 5px 5px 5px 15px;
          padding: 5px 10px; 
        }

      '';
    };
  };

  options.waymodules.bars.waybar.enable = mkEnableOption "Enable waybar";

}
