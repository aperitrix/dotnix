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
        QT_QPA_PLATFORM = "wayland";
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        ELM_DISPLAY = "wl";
        SDL_VIDEODRIVER = "wayland";
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
        gaps = 10;
        default-column-width = {
          proportion = 0.5;
        };
        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#cba6f7";
          inactive.color = "#6c7086";
        };
      };

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 15.0;
            top-right = 15.0;
            bottom-right = 15.0;
            bottom-left = 15.0;
          };
          clip-to-geometry = true;
        }
      ];

      binds = {
        "Mod+Return".action.spawn = "foot";
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

        "Mod+Left".action.focus-monitor-left = { };
        "Mod+Down".action.focus-workspace-down = { };
        "Mod+Up".action.focus-workspace-up = { };
        "Mod+Right".action.focus-monitor-right = { };

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
        "Mod+C".action.center-column = { };

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
