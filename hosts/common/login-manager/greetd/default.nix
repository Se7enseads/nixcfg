{ config, lib, ... }:
with lib;
let selected = config.login-manager.manager == "greetd";

in {
  imports = [ ./regreet.nix ./tuigreet.nix ];

  options.login-manager.greetd = {
    greeter = mkOption {
      type = types.enum [ "tuigreet" "regreet" ];
      default = "tuigreet";
      description = "The greeter to use 'tuigreet' or 'regreet'.";
    };
  };

  config = mkIf selected { services.greetd.enable = true; };
}
