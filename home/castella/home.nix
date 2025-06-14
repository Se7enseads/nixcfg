{ config, lib, ... }:

with lib; {
  home.username = mkDefault "castella";
  home.homeDirectory = mkDefault "/home/${config.home.username}";

  # Do not change this unless you know what you are doing.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
