{ config, lib, ... }:

with lib;
let cfg = config.features.cli.starship;
in {

  config = mkIf cfg.enable {

    programs.starship = {
      enable = true;
      settings = {

        format = ''
          $hostname $directory $git_branch$git_status$nix_shell
          $time$character$cmd'';
        right_format = "$direnv$cmd_duration";

        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
          vicmd_symbol = "[└>](bold yellow)";
        };

        cmd_duration = {
          min_time = 2000;
          format = "took [$duration](bold yellow)";
        };

        directory = {
          format = "[$path]($style)[$read_only]($read_only_style)";
          style = "bold italic blue";
          read_only = "🔒";
          read_only_style = "red";
          truncation_length = 1;
          truncate_to_repo = true;
        };

        direnv = { disabled = false; };

        git_branch = {
          format = "on [$symbol $branch ]($style)";
          style = "bold purple";
          symbol = "";
        };

        git_status = {
          format = "$all_status$ahead_behind";
          style = "bright-white";
          ahead = "🏎️ ×\${count} ";
          behind = "🐢 ×\${count} ";
          conflicted = "⚔️ ";
          deleted = "🗑️ ×\${count} ";
          diverged = "🔱 🏎️ ×\${ahead_count} 🐢 ×\${behind_count} ";
          modified = "📝 ×\${count} ";
          renamed = "📛 ×\${count} ";
          staged = "🗃️ ×\${count} ";
          stashed = "📦 ";
          untracked = "🛤️ ×\${count} ";
        };

        hostname = {
          format = "[$hostname]($style)";
          style = "bold dimmed white";
          disabled = false;
          ssh_only = true;
          trim_at = "-";
        };

        nix_shell = {
          format = "via [ $state( ($name))](bold blue) ";
          disabled = false;
          impure_msg = "[impure](bold red)";
          pure_msg = "[pure](bold green)";
          unknown_msg = "[unknown](bold yellow)";
        };

        time = {
          disabled = false;
          format = "[✦](blue) at [$time](bold green) ";
        };
      };
    };
  };

  options.features.cli.starship.enable = mkEnableOption "Enable starship";
}
