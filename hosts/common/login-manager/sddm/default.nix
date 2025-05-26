{ lib, ... }:
with lib; {
  options.login-manager.sddm = {
    theme = mkOption {
      type = types.str;
      default = "";
      description = "Theme to use with SDDM.";
    };
  };

  # You can add conditional config here for sddm if enabled
}
