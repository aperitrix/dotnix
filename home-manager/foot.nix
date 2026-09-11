{ config, ... }:
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font Mono:size=11";
        shell = "fish";
      };
      "colors-dark".alpha = "0.85";
      "colors-dark".blur = true;
      "colors-light".alpha = "0.85";
      "colors-light".blur = true;
      scrollback = {
        lines = 10000;
      };
    };
  };
}
