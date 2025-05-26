{ config, lib, pkgs, ... }:
with lib;
let
  lm = config.login-manager;
  selected = lm.manager == "greetd" && lm.greetd.greeter == "tuigreet";
in {
  config = mkIf selected {
    services.greetd = let
      tuigreet = "${getExe pkgs.greetd.tuigreet}";
      session = {
        command =
          "${tuigreet} -g 'Welcome to ${config.networking.hostName}!' --remember --remember-session --time --time-format '%I:%M %p | %a • %h | %F' --cmd 'uwsm start hyprland-uwsm.desktop'";
        user = "castella"; # TODO: Make this dynamic based on user
      };

    in {
      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
      };
    };
  };
}
