{ config, lib, ... }:

with lib;
let cfg = config.features.cli.direnv;
in {

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };

  options.features.cli.direnv.enable = mkEnableOption "Enable direnv";
}
