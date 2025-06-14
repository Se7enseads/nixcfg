{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ acpi git neovim tlp wget ];

  programs = { fish.enable = true; };
}
