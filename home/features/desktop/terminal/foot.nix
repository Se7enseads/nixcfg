{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.terminal.foot;

in {
  config = mkIf cfg.enable {

    home.sessionVariables = { TERMINAL = "foot"; };

    programs.foot = {
      enable = true;
      settings = {
        main = {
          include = [ "~/.cache/wal/colors-foot.ini" ];
          shell = "fish";
          term = "foot";
          title = "Foot Terminal";
          app-id = "foot-terminal";
          dpi-aware = true;
          font = "JetBrainsMono Nerd Font:size=12:antialias=true";
          pad = "8x8";
          letter-spacing = 1;
          bold-text-in-bright = true;
        };

        scrollback = { lines = 1000; };

        url = { launch = "${getExe' pkgs.xdg-utils "xdg-open"} \${url}"; };

        cursor = {
          style = "beam";
          beam-thickness = 1.5;
          blink = false;
        };

        colors = {
          jump-labels = "11111b fab387";

          selection-background = "cdd6f4";
          selection-foreground = "414356";

          search-box-no-match = "11111b f38ba8";
          search-box-match = "cdd6f4 313244";

          urls = "89b4fa";
        };

        search-bindings = {
          cancel = "Escape";
          find-next = "F3 Control+g";
          find-prev = "Shift+F3";
        };
      };
    };
  };

  options.features.desktop.terminal.foot.enable =
    mkEnableOption "Enable foot terminal";
}
