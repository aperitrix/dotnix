{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    shellAliases = {
      ma = "export PAGER='most' & man";

      nix-shell = "nix-shell --command \"fish\"";

      mkdir = "mkdir -p";
      tree = "tree -C";
    };

    shellAbbrs = {
      ns = "nix-shell";

      nrs = "sudo nixos-rebuild switch --flake ~/.setup/#dell-laptop";

      poweroff = "systemctl poweroff";
      reboot = "systemctl reboot";

      v = "nvim";

      # Git
      ga = "git add";
      gaa = "git add .";
      gb = "git branch";
      gc = "git commit -m";
      gco = "git checkout";
      gd = "git diff";
      gf = "git fetch";
      gm = "git merge";
      gp = "git push";
      gpl = "git pull";
      gr = "git rebase";
      gs = "git status";
      gsh = "git stash";
      gshp = "git stash pop";
    };
  };
}
