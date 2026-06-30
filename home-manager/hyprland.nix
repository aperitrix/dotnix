{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    wofi
    waybar
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

      monitor = [ ",preferred,auto,1" ];

      input = {
        kb_layout = "us";
        kb_variant = "alt-intl";
      };

      bind = [
        "$mod, Return, exec, kitty"
        "$mod SHIFT, Q, killactive"
        "$mod, Space, exec, wofi --show drun"
        "$mod SHIFT, E, exit"
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

      exec-once = [
        "waybar"
      ];
    };
  };
}
