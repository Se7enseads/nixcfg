{ config, lib, pkgs, ... }:

with lib;
let cfg = config.waymodules.rofi;

in {
  config = mkIf cfg.enable {

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {

        # ---------- General setting ----------
        modes = "drun,run";
        font = "Mono 12";
        show-icons = true;
        # icon-theme = "Papirus"; # TODO: get papirus
        case-sensitive = false;
        cycle = true;
        filter = "";
        scroll-method = 1;
        click-to-exit = true;
        normalize-match = true;
        steal-focus = true;

        # ---------- Matching setting ----------
        matching = "normal";
        tokenize = true;

        # ---------- Drun settings ----------
        drun-categories = "";
        drun-match-fields = "name,generic,exec,categories,keywords";
        drun-display-format =
          "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        drun-show-actions = false;
        drun-url-launcher = "xdg-open";
        drun-use-desktop-cache = false;
        drun-reload-desktop-cache = false;

        # ---------- Run settings ----------
        run-command = "uwsm app -- {cmd}";
        run-shell-command = "{terminal} -e {cmd}";

        # ---------- Fallback Icon ----------
        application-fallback-icon = "application-x-addon";

        # ---------- History and Sorting ----------
        disable-history = true;
        sort = false;
        sorting-method = "normal";
        max-history-size = 25;

        # ---------- Display setting ----------
        display-run = "Run";
        display-drun = "Apps";

        # ---------- Misc setting ----------
        threads = 0;
      };
    };
  };

  options.waymodules.rofi.enable =
    mkEnableOption "Enable rofi application launcher";
}
