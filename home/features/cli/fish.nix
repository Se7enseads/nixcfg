{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.features.cli;
  direnvEnabled = cfg.direnv.enable or false;
  fastfetchEnabled = cfg.fastfetch.enable or false;
  starshipEnabled = cfg.starship.enable or false;
in {

  config = mkIf cfg.fish.enable {

    home.packages = with pkgs; [ fishPlugins.done fishPlugins.fzf-fish fzf ];

    programs = {
      fish = {
        enable = true;
        loginShellInit =
          concatStringsSep "\n" (optional fastfetchEnabled "fastfetch");
        shellInit = concatStringsSep "\n" ([ "set -g fish_greeting" ]
          ++ optional direnvEnabled "direnv hook fish | source"
          ++ optional starshipEnabled "starship init fish | source");
      };
    };
  };

  options.features.cli.fish.enable = mkEnableOption "Enable fish shell";
}
