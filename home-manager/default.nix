{ config, pkgs, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };

  # Import everything else in the directory
  imports =
    with builtins;
    map (fn: ./${fn}) (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));
}
