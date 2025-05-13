{ config, lib, ... }:

with lib;
let cfg = config.waymodules.bars.ignis;
in {
  config = mkIf cfg.enable {
    #TODO: configure ignis
  };
  options.waymodules.bars.ignis.enable = mkEnableOption "Enable Ignis bar";
}
