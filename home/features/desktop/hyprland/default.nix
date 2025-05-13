{ config, lib, pkgs, inputs, ... }:

with lib;
let
  hyprland = config.features.desktop.hyprland;
  wayland = config.waymodules;
in {

  imports = [
    ../common/wayland
    ./binds.nix
    ./hyprpanel.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  config = mkIf hyprland.enable {

    hyprmodules = {
      hyprlock.enable = false;
      hypridle.enable = false;
      hyprpanel.enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;

      sourceFirst = true;

      settings = {
        source = "~/.cache/wal/colors-hyprland.conf";

        exec-once = [
          (getExe pkgs.fusuma) # TODO: add fusuma option
          "polkit-agent-helper-1" # TODO: add polkit
          "poweralertd" # TODO: look for a better alternative
          "swww-daemon" # TODO: add swww
          "systemctl start --user polkit-gnome-authentication-agent-1"
          (optionalString wayland.bars.ignis.enable "ignis init")
          "waypaper --restore" # TODO: add waypaper
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
        ];

        env = [
          "ELECTRON_OZONE_PLATFORM_HINT,x11"
          "HYPRCURSOR_SIZE,24"
          "HYPRSHOT_DIR,Pictures/Screenshots"
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "XCURSOR_SIZE,24"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 3;

          "col.active_border " = "$color11";
          "col.inactive_border" = "rgba(595959aa)";

          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";

          snap = { enabled = true; };
        };

        decoration = {
          rounding = 5;

          active_opacity = 1.0;
          inactive_opacity = 1.0;
        };

        animations = {
          enabled = true;
          first_launch_animation = false;

          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"
            "easeOutSine, 0.61, 1, 0.88, 1"
            "easeOutQuad, 0.5, 1, 0.89, 1"
            "easeOutCubic, 0.33, 1, 0.68, 1"
            "easeOutQuart, 0.25, 1, 0.5, 1"
            "easeOutQuint, 0.22, 1, 0.36, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
          ];

          animation = [
            "windows, 1, 3, easeOutExpo, popin 75%"
            "border, 1, 4, easeOutCubic"
            "fade, 1, 2, easeOutCubic"
            "fadeSwitch, 1, 1, easeOutCubic"
            "fadeDim, 1, 1, easeOutCubic"
            "workspaces, 1, 6, easeOutExpo"
            "specialWorkspace, 1, 4, easeOutExpo, slidevert"
            "layers,0"
          ];
        };

        dwindle = { pseudotile = true; };

        misc = {
          close_special_on_empty = true;
          disable_hyprland_logo = true;
          focus_on_activate = true;
          force_default_wallpaper = 0;
          new_window_takes_over_fullscreen = 2;
          vfr = true;
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
        };

        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        windowrule = [
          "float, class:qalculate-gtk"
          "float, class:.blueman-manager-wrapped"
          "float, class:waypaper"
          "float, class:com.nextcloud.desktopclient.nextcloud"
        ];

        windowrulev2 = [
          "suppressevent maximize, class:.*"

          "float, class:(com.saivert.pwvucontrol)"
          "size 875 610, class:(com.saivert.pwvucontrol)"

          "size 580 530, class:(.blueman-manager-wrapped)"

          "float, title:^(Picture-in-Picture)$"
          "size 764 383, title:^(Picture-in-Picture)$"

          "size  985 607, class:(waypaper)"
          "size  950 680, class:(com.nextcloud.desktopclient.nextcloud)"

          "workspace special:spotify silent,title:^(Spotify Premium)$"

          "float, title:^(KeePassXC - Browser Access Request)"
          "float, title:^(Generate Password)$"
        ];
      };
    };
  };

  options.features.desktop.hyprland.enable =
    mkEnableOption "Enable Hyprland window manager";
}
