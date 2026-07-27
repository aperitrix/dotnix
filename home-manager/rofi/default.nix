{ pkgs, config, ... }:
{
  programs.rofi = {
    enable = false;
    theme = ./round.rasi;
  };
}
