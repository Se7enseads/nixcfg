{
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };

    xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };
}
