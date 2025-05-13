{ pkgs, ... }: {
  home.packages = with pkgs; [ font-manager jetbrains-mono noto-fonts ];
}
