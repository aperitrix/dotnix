{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    wofi
    wl-clipboard
    wlogout
    wlr-randr
    hyprshot
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    systemd.enable = false;

    configType = "hyprlang";

    settings = {
      "$mod" = "SUPER";
      env = [
        "WLR_NO_HARDWARE_CURSORS,1"
        "XCURSOR_SIZE,24"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
      ];

      monitor = [
        ",preferred,auto,1"
      ];

      general = {
        border_size = 2;
        gaps_in = 4;
        gaps_out = 6;
        "col.inactive_border" = "rgb(150457)";
        "col.active_border" = "rgb(C85CE7)";
        resize_on_border = true;
      };

      decoration = {
        rounding = 10;
      };

      animations = {
        enabled = true;
        animation = [
          "windowsMove, 1, 5, default, slide"
        ];
      };

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.6;
          "tap-to-click" = true;
          "tap-and-drag" = true;
        };
        follow_mouse = 1; # Cursor movement will always change focus to the window under the cursor.
        numlock_by_default = true;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      bind = [
        "$mod, Return, exec, kitty"
        "$mod SHIFT, Q, killactive"
        "$mod, Space, exec, wofi --show drun"
        "$mod SHIFT, E, exit"

        ", PRINT, exec, hyprshot -m region --freeze --output-folder ~/Pictures/"
        "$mod SHIFT, S, exec,hyprshot -m region --freeze --clipboard"

        ", XF86MonBrightnessUp, exec, light -A 5"
        ", XF86MonBrightnessDown, exec, light -U 5"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Move focus
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        # Move windows
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"

        # Resize windows
        "$mod CTRL, H, resizeactive, -10 0"
        "$mod CTRL, J, resizeactive, 0 10"
        "$mod CTRL, K, resizeactive, 0 -10"
        "$mod CTRL, L, resizeactive, 10 0"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (
          builtins.genList (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 10
        )
      );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "waybar"
      ];
    };
  };
}
