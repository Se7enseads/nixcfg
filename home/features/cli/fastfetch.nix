{ config, lib, ... }:

with lib;
let cfg = config.features.cli.fastfetch;
in {

  config = mkIf cfg.enable {

    programs.fastfetch.enable = true;

    xdg.configFile."fastfetch/config.jsonc".text = ''
          
      // Inspired by https://github.com/usgraphics/TR-100
      {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "logo": null,
        "display": {
          "pipe": true,
          "key": {
            "width": 16
          },
          "separator": "│ ",
          "percent": {
            "type": ["bar", "hide-others"]
          },
          "bar": {
            "borderLeft": "",
            "borderRight": "",
            "charElapsed": "█",
            "charTotal": "░",
            "width": 40
          },
          "constants": ["\u001b[42C"]
        },
        "modules": [
          {
            "type": "custom",
            "format": "┌┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┬┐"
          },
          {
            "type": "custom",
            "format": "├┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┤"
          },
          {
            "type": "version",
            "key": " ",
            "format": "│                   FASTFETCH v{version}                   │"
          },
          {
            "type": "custom",
            "format": "│                 TR-100 MACHINE REPORT                 │"
          },
          {
            "type": "custom",
            "format": "├────────────┬──────────────────────────────────────────┤"
          },
          {
            "type": "os",
            "key": "│ OS         │{$1}",
            "format": "{name} {version}"
          },
          {
            "type": "kernel",
            "key": "│ KERNEL     │{$1}"
          },
          {
            "type": "custom",
            "format": "├────────────┼──────────────────────────────────────────┤"
          },
          {
            "type": "title",
            "key": "│ HOSTNAME   │{$1}",
            "format": "{host-name}"
          },
          {
            "type": "host",
            "key": "│ MACHINE    │{$1}",
            "format": "{name}"
          },
          {
            "type": "shell",
            "key": "│ SHELL      │{$1}"
          },
          {
            "type": "terminal",
            "key": "│ TERMINAL   │{$1}"
          },
          {
            "type": "wm",
            "key": "│ WM         │{$1}"
          },
          {
            "type": "custom",
            "format": "├────────────┼──────────────────────────────────────────┤"
          },
          {
            "type": "cpu",
            "key": "│ PROCESSOR  │{$1}",
            "format": "{name}"
          },
          {
            "type": "cpu",
            "key": "│ CORES      │{$1}",
            "format": "{cores-physical} PHYSICAL CORES / {cores-logical} THREADS",
            "showPeCoreCount": false
          },
          {
            "type": "cpu",
            "key": "│ CPU FREQ   │{$1}",
            "format": "{freq-max}{/freq-max}{freq-base}{/}"
          },
          {
            "type": "custom",
            "format": "├────────────┼──────────────────────────────────────────┤"
          },
          {
            "type": "memory",
            "key": "│ MEMORY     │{$1}",
            "format": "{used} / {total} [{percentage}]",
            "percent": {
              "type": ["num"]
            }
          },
          {
            "type": "memory",
            "key": "│ USAGE      │{$1}",
            "format": "",
            "percent": {
              "type": ["bar", "hide-others"]
            }
          },
          {
            "type": "custom",
            "format": "├────────────┼──────────────────────────────────────────┤"
          },
          {
            "type": "disk",
            "key": "│ VOLUME     │{$1}",
            "format": "{size-used} / {size-total} [{size-percentage}]",
            "folders": "/",
            "percent": {
              "type": ["num"]
            }
          },
          {
            "type": "disk",
            "key": "│ DISK USAGE │{$1}",
            "format": "",
            "percent": {
              "type": ["bar", "hide-others"]
            }
          },
          {
            "type": "custom",
            "format": "├────────────┼──────────────────────────────────────────┤"
          },
          {
            "type": "users",
            "key": "│ LAST LOGIN │{$1}",
            "format": "{login-time}{?client-ip} ({client-ip})",
            "myselfOnly": true
          },
          {
            "type": "uptime",
            "key": "│ UPTIME     │{$1}"
          },
          {
            "type": "command",
            "key": "│ OS AGE     │{$1}",
            "text": "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days"
          },
          {
            "type": "custom",
            "format": "└────────────┴──────────────────────────────────────────┘"
          }
        ]
      }

    '';
  };

  options.features.cli.fastfetch.enable = mkEnableOption "Enable fastfetch";
}
