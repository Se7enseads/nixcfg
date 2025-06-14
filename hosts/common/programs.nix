{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ git neovim wget ];

  programs = { fish.enable = true; };
}
