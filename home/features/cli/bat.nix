{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.cli.bat;
in {

  config = mkIf cfg.enable {

    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batgrep
        batman
        batwatch
        prettybat
      ];
    };
  };

  options.features.cli.bat.enable = mkEnableOption "Enable bat";
}
