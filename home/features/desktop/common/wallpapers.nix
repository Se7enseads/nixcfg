{ inputs, ... }:

{
  imports = [ inputs.assets.wallpapers.default ];

  programs.wallpapers = {
    enable = true;
    wallpaperTargetDir = ".config/wallpapers";
  };
}
