{ pkgs, ... }:
{
  programs.swaylock = {
    enable = false;
    package = pkgs.swaylock-effects;
    settings = {
      effect-blur = "20x3";
    };
  };
}
