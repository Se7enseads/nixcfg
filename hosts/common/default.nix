# Common configuration for all hosts
{ lib, inputs, outputs, pkgs, ... }: {

  imports = [ inputs.home-manager.nixosModules.home-manager ./users ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };

    # You can add overlays here
    overlays = builtins.attrValues outputs.overlays;
  };

  nix = {
    settings = {
      experimental-features = "flakes nix-command";
      trusted-users = [
        "castella"
        "root"
      ]; # Set users that are allowed to use the flake command

      substituters =
        [ "https://nix-community.cachix.org" "https://cache.nixos.org/" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    registry = (lib.mapAttrs (_: flake: { inherit flake; }))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  };

  users.defaultUserShell = pkgs.fish;
}
