{
  imports = [ ../common ../features/cli ../features/desktop ./home.nix ];

  features = {

    cli = {
      bat.enable = true;
      direnv.enable = true;
      eza.enable = true;
      fastfetch.enable = true;
      fish.enable = true;
      starship.enable = true;
      zoxide.enable = true;
    };

    desktop = {
      hyprland.enable = true;
      file-manager = { nautilus.enable = true; };
      terminal = { foot.enable = true; };
    };
  };
}
