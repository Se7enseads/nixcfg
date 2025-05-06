{ config, pkgs, inputs, ... }: {
  users.users.coba = {
    initialHashedPassword =
      "$y$j9T$SkwlNgW/ZaocYlRjQfcnB0$Y1p2hLd1SmaF6/ymFiJAf4ctK6NPZhAGIAY3UB1ROtD";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
      "kvm"
      "qemu-libvirtd"
      "libvirtd"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDO7NP3ylBF5/+gyLmAdYzi7Nz4imedOsW5ZDmqZCVaKSZwydKLIPEnDUZTvFG87a1Bkz4+gZrqK3wjhiKcW41Xf+Dk8Olhf4Au5Uw0/Z5kX59sjQk2P2W0wyml/zdlNl43mxlXZ+l4EHDI56ocaIjtCF3rkzFwCrGGNuFpDMNtHg7FrrC8rZNw6c14E42iqCpRpSXIadCiugE3ExEZf5WxNXUEiVeiwyIYlLIeH3WY93RO3rOi9MpXw4SD6Vad0uSg4bmdrli8d1r0JFSuuMB9lrQrDyHm0v49bKoans85MgLa9p1HSVQwYTmiicqKv8a7WHYMyA4m7ahg8/0tRIIelRfdrl6B+RRfvwpahGnkg2eWJAlhbi2hMyNW77kV7x7uhYLzp8nyJOfRrWNH5InUtVp8t0+Hw+GjhP8lHmPEe4n/EGYlc1HhmfldEJra1drfj2g8JRn1S6VLKl2LX0tCLYThZ5DcE7wP9toqCGqDgTdPoRwxhe1aEM30+qbfYfrb9EST6O1JpLP31zT4fGAal5tX6y9NG8Sb6NwkRYYF0Kx1y3w6cGGvH/ILrJc99ku4x6EdFU9nFzy3WvyHkuRNbBpGfg/NhyHmS2aGU7Sychl+y+JWrMMfbFQHqCgDPTaYJIM3dPH3l+nRyc3ohGjlEJgZF/qwRdq1SKl83opR9w=="
    ];
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  home-manager.users.coba =
    import ../../../home/coba/${config.networking.hostName}.nix;
}
