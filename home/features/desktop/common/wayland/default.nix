{ pkgs, ... }:

{
  imports = [ ./rofi.nix ./bars/waybar.nix ./bars/ignis.nix ];

  waymodules = {
    rofi.enable = true;
    bars = {
      waybar.enable = false;
      ignis.enable = false;
    };
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
