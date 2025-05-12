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

        interactiveShellInit =
          concatStringsSep "\n" (optional fastfetchEnabled "fastfetch");

        shellInit = concatStringsSep "\n" ([ "set -g fish_greeting" ]
          ++ optional direnvEnabled "direnv hook fish | source"
          ++ optional starshipEnabled "starship init fish | source");

        functions = {
          __fish_command_not_found_handler = {
            body = "__fish_default_command_not_found_handler $argv[1]";
            onEvent = "fish_command_not_found";
          };

          mc = "mkdir $argv[1] && cd $argv[1]";
          trash = "mv $argv[1] ~/.local/share/Trash/";
        };

        shellAliases = {
          cl = "clear";
          clf = "clear && fastfetch";
          vi = "nvim";
          ".." = "cd ..";
          "..." = "cd ../..";

          ls = "eza --color=always --icons --group-directories-first";
          la = "eza -la --color=always --icons --group-directories-first";
          ll = "eza -l --color=always --icons --group-directories-first";
          lt = "eza -aT --color=always --icons --group-directories-first";
          cat = "bat";
          man = "batman";
          grep = "batgrep";

          # File & folder management
          cp = "cp -ip";
          mv = "mv -i";
          rm = "rm -i";
          mkdir = "mkdir -pv";

          #System commands # FIXME: find a way to make this work
          # system = "clear && nh os switch";
          # home = "clear && nh home switch -b hm.bak";
          # sync = "system && home";
          # upgrade = "update && sync";

          check = "nix flake check ${config.home.homeDirectory}/nixcfg";

          clean = "nh clean all --keep 5";

          dn = "nvim ${config.home.homeDirectory}/nixcfg";
          dc = "code ${config.home.homeDirectory}/nixcfg | exit";

          regit = "sudo chown -R ${config.home.username}:users .git/* ";
        };
      };
    };
  };

  options.features.cli.fish.enable = mkEnableOption "Enable fish shell";
}
