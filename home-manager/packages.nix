{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tree
    tldr
    man-pages
    zip
    unzip
    less
    htop

    wdisplays

    discord

    # Fonts
    font-awesome
    fira-code
    fira-code-symbols
    material-design-icons
    nerd-fonts.jetbrains-mono

    kdePackages.dolphin
    kdePackages.qtsvg # icons for dolphin
  ];

}
