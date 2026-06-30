{ config, pkgs, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };
 wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    extraConfig = ''
      env = WLR_NO_HARDWARE_CURSORS,1
      env = XCURSOR_SIZE,24
      env = WLR_RENDERER_ALLOW_SOFTWARE,1

      monitor = ,preferred,auto,1

      input  {
        kb_layout = us
        kb_variant = alt-intl
      }

      bind = SUPER, Return, exec, kitty
      bind =SUPER, Q, killactive
      bind =SUPER, Space, exec, wofi --show drun
      bind =SUPER SHIFT, E, exit
''; 
    settings = {
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
        "SUPER, Return, exec, kitty"
        "SUPER, Q, killactive"
        "SUPER, Space, exec, wofi --show drun"
        "SUPER SHIFT, E, exit"
      ];

      exec-once = [
        "waybar"
      ];
    };
  };

  home.packages = with pkgs; [
    kitty
    wofi
    waybar
  ];
   programs.git = {
    enable = true;

    # User configuration
    userName = "Annabelle Chevreau";
    userEmail = "annabelle" + "." + "chevreau" + "@gmail.com";

    ignores = [ "*.swp" ];

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
    };

    # Aliases
    aliases = {
      gs = "git status";
      ga = "git add";
      gaa = "git add .";
      gc = "git commit -m";
      gp = "git push";
    };
  };
}
