{ pkgs, ... }:

{
  imports = [ ./rofi.nix ./bars/waybar.nix ./bars/ignis.nix ./waypaper.nix ];

  waymodules = {
    bars = {
      waybar.enable = false;
      ignis.enable = false;
    };
    rofi.enable = true;
    waypaper.enable = true;
  };

  home.packages = with pkgs; [
    cliphist
    grim
    imagemagick
    libsForQt5.qt5ct
    nwg-look
    qt5.qtwayland
    qt6.qtwayland
    slurp
    wl-clipboard
  ];
}
