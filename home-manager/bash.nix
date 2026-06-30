{ ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
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
