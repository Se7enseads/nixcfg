{ pkgs ? import <nixpkgs> { }, ... }: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git

      nixd
      nvd
      nix-output-monitor
      nixfmt-classic
      statix
      vulnix
      deadnix
    ];
  };
}
