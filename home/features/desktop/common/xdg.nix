# Borrowed from Orangc's NixOS configuration
# https://github.com/orangci/dots/blob/master/homes/orangc/misc/xdg.nix

{ config, pkgs, ... }: {
  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = {
      enable = pkgs.stdenv.isLinux;
      createDirectories = true;

      desktop = null;
      download = "${config.home.homeDirectory}/dl";
      documents = "${config.home.homeDirectory}/docs";

      publicShare = null;
      templates = null;

      pictures = "${config.home.homeDirectory}/media";
      music = "${config.home.homeDirectory}/media/music";
      videos = "${config.home.homeDirectory}/media/videos";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
        XDG_MAIL_DIR = "${config.xdg.userDirs.documents}/mail";
      };
    };
  };
}
