{ config, lib, ... }:

with lib;
let cfg = config.features.cli.eza;
in {

  config = mkIf cfg.enable {

    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };

  options.features.cli.eza.enable = mkEnableOption "Enable eza";
}
