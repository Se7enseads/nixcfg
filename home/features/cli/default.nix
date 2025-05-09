{ pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fastfetch.nix
    ./fish.nix
    ./starship.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [ btop coreutils dua fd jq ripgrep tealdeer foot ];
}
