{
  description = ''

    NixOS configuration for Baklava, a NixOS-based system.

      Config curtesy of:

      M3tam3re
        X: https://x.com/@m3tam3re
        YT channel: https://www.youtube.com/@m3tam3re

      Misterio77
        https://github.com/Misterio77/nix-starter-configs
        https://github.com/Misterio77/nix-config
  '';

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, home-manager, nixpkgs, systems, ... }@inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f:
        lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in {
      inherit lib;

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        baklava = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/baklava ];
        };
      };

      homeConfigurations = {
        "coba@baklava" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/coba/baklava.nix ];
        };
      };
    };
}
