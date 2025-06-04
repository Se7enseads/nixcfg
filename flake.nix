{
  description = ''

    NixOS configuration for Okashi, a NixOS-based system.

      Config curtesy of:

      M3tam3re
        X: https://x.com/@m3tam3re
        YT channel: https://www.youtube.com/@m3tam3re

      Misterio77
        https://github.com/Misterio77/nix-starter-configs
        https://github.com/Misterio77/nix-config
  '';

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
    };

    assets = {
      url = "github:Se7enseads/assets";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, agenix, home-manager, nixpkgs, systems, ... }@inputs:
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
      username = "castella";
    in {
      inherit lib;

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      overlays = import ./overlays { inherit inputs; };

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      nixosConfigurations = {
        okashi = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs username; };
          modules = [
            ./hosts/okashi
            inputs.disko.nixosModules.disko
            agenix.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        "${username}@okashi" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs username; };
          modules = [ ./home/${username}/okashi.nix ];
        };
      };
    };
}
