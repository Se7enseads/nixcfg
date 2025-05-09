{
  imports = [ ../common ../features/cli ./home.nix ];

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
  };
}
