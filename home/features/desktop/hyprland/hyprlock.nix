{ config, lib, ... }:
with lib;
let cfg = config.hyprmodules.hyprlock;
in {
  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      sourceFirst = true;
      settings = {
        source = "$HOME/.cache/wal/colors-hyprland.conf";

        general = {
          grace = 10;
          ignore_empty_input = true;
          hide_cursor = true;
        };

        background = {
          monitor = "";
          blur_size = 7;
          path = "screenshot";
          blur_passes = 3;
          contrast = 1.3;
          brightness = 0.8;
          vibrancy = 0.21;
          vibrancy_darkness = 0;
        };

        label = [
          # Hours
          {
            monitor = "";
            text =
              ''cmd[update:1000] echo "<b><big> $(date +"%I") </big></b>"'';
            color = "$color11";
            font_size = 400;
            font_family = "Serif Bold";
            shadow_passes = 3;
            shadow_size = 4;
            position = "0, 400";
            halign = "center";
            valign = "center";
          }

          # Minutes
          {
            monitor = "";
            text =
              ''cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"'';
            color = "$color6";
            font_size = 400;
            font_family = "Serif Bold";
            shadow_passes = 3;
            shadow_size = 4;
            position = "0, -100";
            halign = "center";
            valign = "center";
          }

          # Today
          {
            monitor = "";
            text = ''
              cmd[update:18000000] echo "<b><big> "$(date +'%A')" </big></b>"'';
            color = "$color7";
            font_size = 150;
            font_family = "NotoSerif Nerd Font";
            position = "0 ,250";
            halign = "center";
            valign = "center";
          }

          # Week
          {
            monitor = "";
            text = ''cmd[update:18000000] echo "<b> "$(date +'%d %b')" </b>"'';
            color = "$color7";
            font_size = 100;
            font_family = "JetBrainsMono Nerd Font 10";
            position = "0 ,-350";
            halign = "center";
            valign = "center";
          }

          # Uptime
          {
            monitor = "";
            text = ''
              cmd[update:60000] echo "<b> "$(uptime)" </b>"''; # TODO: add uptime command
            color = "$color5";
            font_size = 60;
            font_family = "JetBrainsMono Nerd Font 10";
            position = "0,0";
            halign = "right";
            valign = "bottom";
          }
        ];

        input-field = {
          monitor = "";
          size = "750 ,130";
          outline_thickness = 0;
          dots_size = 0.3;
          dots_spacing = 0.64;
          dots_center = true;
          rounding = 22;
          outer_color = "$color6";
          inner_color = "$color6";
          font_color = "$color11";
          fade_on_empty = true;
          placeholder_text = "<i>Password ...</i>";
          position = "0,120";
          halign = "center";
          valign = "bottom";
        };
      };
    };
  };
  options.hyprmodules.hyprlock.enable = mkEnableOption "Enable Hyprlock";
}
