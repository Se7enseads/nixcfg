{ config, lib, pkgs, ... }:

with lib;
let cfg = config.features.desktop.file-manager.nautilus;

in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ nautilus ];

    xdg.mimeApps.defaultApplications."inode/directory" =
      [ "org.gnome.Nautilus.desktop" ];
  };

  options.features.desktop.file-manager.nautilus.enable =
    mkEnableOption "Enable Nautilus file manager";
}
