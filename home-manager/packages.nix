{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tree
    tldr
    man-pages
    zip
    unzip
    less

    wdisplays

    discord

    # Fonts
    font-awesome
    fira-code
    fira-code-symbols
    material-design-icons
    nerd-fonts.fira-code

    kdePackages.dolphin
    kdePackages.qtsvg # icons for dolphin
  ];

}
