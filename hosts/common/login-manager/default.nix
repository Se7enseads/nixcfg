{ lib, ... }:
with lib; {
  imports = [ ./greetd ./sddm ];

  options.login-manager = {
    manager = mkOption {
      type = types.enum [ "greetd" "sddm" ];
      default = "greetd";
      description = "Select which login manager to enable.";
    };
  };
}
