{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      nixd
      statix
    ];
  };
}
