{
  imports =
    [ ../common ./configuration.nix ../common/login-manager ./secrets.nix ];

  login-manager = {
    manager = "greetd"; # enum { greetd, sddm }
    greetd.greeter = "tuigreet"; # enum {tuigreet, regreet}
    sddm.theme = ""; # TODO: add themes eg.str, {tokyo, chilli}
  };
}
