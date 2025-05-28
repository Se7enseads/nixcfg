# Borrowed some from Misterio77's Hyprland config
# https://github.com/Misterio77/nix-config/tree/main/home/gabriel/features/desktop/hyprland

{ config, lib, pkgs, ... }:

with lib;
let
  pactl = getExe' pkgs.pulseaudio "pactl";
  prefix = "uwsm app --"; # uwsm

  workspaces = builtins.concatLists (builtins.genList (i:
    let ws = i + 1;
    in [
      "SUPER, code:1${toString i}, workspace, ${toString ws}"
      "SUPER SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
    ]) 9);

in {
  home.packages = with pkgs; [ hyprshot ];

  wayland.windowManager.hyprland.settings = {
    bindm = [ "SUPER, mouse:272, movewindow" ];

    bind =

      let
        wayland = config.waymodules;
        hyprland = config.hyprmodules;

        bars = optional wayland.bars.waybar.enable
          "SUPERSHIFT, B, exec, pkill waybar; waybar"
          ++ optional hyprland.hyprpanel.enable
          "SUPERSHIFT, B, exec, hyprpanel -q; hyprpanel";

        locks = optional hyprland.hyprlock.enable
          "SUPER, L, exec, ${prefix} hyprlock";

        defaultApp = type:
          "${getExe pkgs.handlr-regex} launch ${escapeShellArg type}";

      in [
        # Modifiers: SUPER + KEY
        "SUPER, A, exec, ${prefix} rofi -show drun" # TODO: modularize for rofi
        "SUPER, E, exec, ${prefix} ${defaultApp "inode/directory"}"
        "SUPER, F, exec, ${prefix} ${defaultApp "x-schema-handler/https"}"
        "SUPER, I, exec, if hyprctl clients | grep title: config; then notify-send 'Already Open'; else ${prefix} code $DOTFILES; fi" # FIXME: set $DOTFILES
        "SUPER, J, togglesplit"
        "SUPER, M, exec, uwsm stop"
        "SUPER, P, pseudo"
        "SUPER, Q, killactive"
        "SUPER, S, exec, if hyprctl clients | grep spotify; then echo; else ${prefix} spotify; fi" # TODO: make spotify options
        "SUPER, S, togglespecialworkspace, spotify"
        "SUPER, T, exec, ${prefix} $TERM" # FIXME: fix terminal
        "SUPER, V, exec, cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy" # TODO: modularize for rofi
        "SUPER, W, togglefloating" # FIXME: fix floating windows

        # Modifiers: SUPER + ALT + KEY
        "SUPER ALT, S, exec, ${prefix} wl-ocr" # on screen text recognition/copy # TODO: get wl-ocr working

        # Modifiers: SUPER + CTRL + KEY
        "SUPER CTRL, S, exec, ${prefix} hyprshot -m output" # Screenshot Screen

        # Modifiers: SUPER + SHIFT + KEY
        "SUPERSHIFT, W, exec, ${prefix} waypaper"
        "SUPERSHIFT, F, fullscreen"

        # Modifiers: CTRL + ALT + KEY
        "CTRL ALT, S, exec, ${prefix} hyprshot -m region" # Screenshot Region

        # Modifiers: CTRL + SHIFT + KEY
        "CTRL SHIFT, S, exec, ${prefix} hyprshot -m window" # Screenshot Window

        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        ", XF86Calculator, exec, ${prefix} qalculate-gtk" # TODO: get qalculate working
      ] ++ workspaces ++ bars ++ locks;

    bindl = [
      ", XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle" # Toggle microphone
      ", XF86AudioMute, exec, ${pactl} set-sink-mute @DEFAULT_SINK@ toggle" # Toggle mute
    ];

    bindle = let brightness = getExe pkgs.brightnessctl;
    in [
      ", XF86AudioLowerVolume, exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
      ", XF86AudioRaiseVolume, exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"

      "SHIFT,XF86AudioRaiseVolume, exec, ${pactl} set-source-volume @DEFAULT_SOURCE@ +5%"
      "SHIFT,XF86AudioLowerVolume, exec, ${pactl} set-source-volume @DEFAULT_SOURCE@ -5%"

      ", XF86MonBrightnessDown, exec, ${brightness} set 2%-"
      ", XF86MonBrightnessUp, exec, ${brightness} set +2%"
    ];
  };
}
