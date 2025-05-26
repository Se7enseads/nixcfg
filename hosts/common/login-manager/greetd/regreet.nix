{ config, lib, ... }:
with lib;
let
  lm = config.login-manager;
  selected = lm.manager == "greetd" && lm.greetd.greeter == "regreet";
in { config = mkIf selected { programs.regreet = { enable = true; }; }; }
