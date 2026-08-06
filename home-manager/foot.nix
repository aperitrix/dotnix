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
      "colors-dark".background  = "1e1e2eBF";  # 0.75 alpha
      "colors-light".background = "eff1f5BF";
    };
  };
}
