{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    kitty
    wofi
    wl-clipboard
    wlogout
    wlr-randr
  ];

  programs.niri = {
    settings = {
      prefer-no-csd = true;

      environment = {
        WLR_NO_HARDWARE_CURSORS = "1";
        XCURSOR_SIZE = "24";
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
        NOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
      };

      outputs = {
        "DP-1" = {
          scale = 0.8;
          position = {
            x = 0;
            y = 0;
          };
        };
      };

      input = {
        keyboard.xkb = {
          layout = "us";
          variant = "intl";
        };
        touchpad = {
          natural-scroll = true;
          scroll-factor = 0.6;
          tap = true;
          drag = true;
        };
        focus-follows-mouse.enable = true;
      };

      layout = {
        gaps = 6;
        border = {
          enable = true;
          width = 2;
          active.color = "#C85CE7";
          inactive.color = "#150457";
        };
      };

      binds = {
        "Mod+Return".action.spawn = "kitty";
        "Mod+Shift+Q".action.close-window = { };
        "Mod+Space".action.spawn-sh = "noctalia msg panel-toggle launcher";
        "Mod+Shift+E".action.quit = { };
        "Mod+X".action.spawn-sh = "noctalia msg session lock";

        "Print".action.spawn-sh = "noctalia msg screenshot-region";
        "Mod+Shift+S".action.spawn-sh = "noctalia msg screenshot-region";

        "XF86MonBrightnessUp".action.spawn-sh = "noctalia msg brightness-up";
        "XF86MonBrightnessDown".action.spawn-sh = "noctalia msg brightness-down";

        "XF86AudioRaiseVolume".action.spawn-sh = "noctalia msg volume-up";
        "XF86AudioLowerVolume".action.spawn-sh = "noctalia msg volume-down";
        "XF86AudioMute".action.spawn-sh = "noctalia msg volume-mute";

        "Mod+H".action.focus-column-or-monitor-left = { };
        "Mod+J".action.focus-window-or-workspace-down = { };
        "Mod+K".action.focus-window-or-workspace-up = { };
        "Mod+L".action.focus-column-or-monitor-right = { };

        "Mod+Shift+H".action.consume-or-expel-window-left = { };
        "Mod+Shift+J".action.move-window-down-or-to-workspace-down = { };
        "Mod+Shift+K".action.move-window-up-or-to-workspace-up = { };
        "Mod+Shift+L".action.consume-or-expel-window-right = { };

        "Mod+Ctrl+H".action.set-column-width = "-10%";
        "Mod+Ctrl+L".action.set-column-width = "+10%";
        "Mod+Ctrl+J".action.set-window-height = "+10%";
        "Mod+Ctrl+K".action.set-window-height = "-10%";

        "Mod+Alt+L".action.move-workspace-to-monitor-right = { };
        "Mod+Alt+H".action.move-workspace-to-monitor-left = { };
        "Mod+Alt+J".action.move-workspace-to-monitor-down = { };
        "Mod+Alt+K".action.move-workspace-to-monitor-up = { };
        "Mod+F".action.maximize-column = { };

        "Mod+W".action.toggle-column-tabbed-display = { };
      };
      spawn-at-startup = [
        { argv = [ "noctalia" ]; }
      ];

      switch-events = {
        lid-close.action.spawn = "noctalia msg session lock-and-suspend";
      };
    };
  };
}
