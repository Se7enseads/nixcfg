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
          path = entry.path;
          name = entry.name or "";
          label = if name != "" then " ${name}" else "";
        in "file://${config.home.homeDirectory}/${path}${label}") [
          {
            path = ".config";
            name = "Config";
          }
          {
            path = "dotfiles";
            name = "Settings";
          }
          { path = "Documents"; }
          { path = "Downloads"; }
          { path = "Nextcloud"; }
          { path = "Node"; }
          { path = "Pictures"; }
          { path = "Python"; }
          { path = "Rust"; }
          { path = "Videos"; }
        ];
    };

  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
