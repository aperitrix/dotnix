{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tree
    tldr
    man-pages
    zip
    unzip
    less

    discord

    # Fonts
    font-awesome
    fira-code
    fira-code-symbols
    material-design-icons
  ];

}
