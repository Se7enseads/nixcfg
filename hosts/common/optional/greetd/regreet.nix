{ pkgs, ... }: {

  programs.regreet = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Cyan-Darkest";
    };
  };
  services.greetd.enable = true;
}
