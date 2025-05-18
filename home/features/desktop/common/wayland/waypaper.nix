{ config, lib, pkgs, ... }:

with lib;
let
  wayland = config.waymodules;
  hyprland = config.hyprmodules;
  bar = concatStringsSep "; "
    (optional wayland.bars.waybar.enable "pkill waybar; waybar"
      ++ optional hyprland.hyprpanel.enable "hyprpanel -q; hyprpanel");
in {
  config = mkIf wayland.waypaper.enable {

    home.packages = with pkgs; [ waypaper swww pywal16 pywalfox-native ];

    xdg.configFile."waypaper/config.ini".text = ''
      [Settings]
      language = en
      folder = ~/${config.programs.wallpapers.wallpaperTargetDir}
      wallpaper =
      backend = swww
      monitors = All
      fill = fill
      sort = name
      color = #ffffff
      subfolders = True
      show_hidden = False
      show_gifs_only = False
      post_command = swww img $wallpaper --transition-bezier .43,1.19,1,.4 --transition-fps 60 --transition-type any --transition-pos 0.925,0.977 --transition-duration 2; wal -i $wallpaper -n; pywalfox update; ${bar}
      number_of_columns = 3
    '';

  };
  options.waymodules.waypaper.enable = mkEnableOption "Enable waypaper";
}
