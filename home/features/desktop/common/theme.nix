{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ pywal16 pywalfox-native ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Cyan-Darkest";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    font = {
      name = "Sans";
      size = 12;
    };

    gtk3 = {
      bookmarks = map (entry:
        let
          inherit (entry) path;
          name = entry.name or "";
          label = if name != "" then " ${name}" else "";
        in "file://${config.home.homeDirectory}/${path}${label}") [
          {
            path = ".config";
            name = "Config";
          }
          {
            name = "Dotfiles";
            path = ".dotfiles";
          }
          {
            name = "Docs";
            path = "docs";
          }
          {
            name = "Downloads";
            path = "dl";
          }
          { path = "Nextcloud"; }
          { path = "Node"; }
          {
            name = "Pictures";
            path = "media";
          }
          { path = "Python"; }
          { path = "Rust"; }
          {
            name = "Videos";
            path = "media/videos";
          }
        ];
    };

  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
