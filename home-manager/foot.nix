{ config, ... }:
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "screen-256color";
        font = "FiraCode Nerd Font Mono:size=11:fontfeatures=ss02 calt zero";
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
