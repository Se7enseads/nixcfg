{ lib, outputs, pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = builtins.attrValues outputs.overlays;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "flakes" "nix-command" ];
      warn-dirty = false;
    };
  };
}
