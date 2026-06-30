{ pkgs, lib, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;

    settings = {
      shell = "${lib.getExe pkgs.bash}";

      background_opacity = "0.75";

      font_family = "Fira Code";
      font_size = "11";

      confirm_os_window_close = "0";
    };
    extraConfig = ''
      copy_on_select yes

      map ctrl+c       copy_and_clear_or_interrupt
      map ctrl+v       paste_from_clipboard
    '';
  };
}
