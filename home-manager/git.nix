{ ... }:
{
  programs.git = {
    enable = true;

    ignores = [
      "*~"
      "*.swp"
    ];

    settings = {
      user = {
        name = "Annabelle Chevreau";
        email = "annabelle" + "." + "chevreau" + "@gmail.com";
      };

      core.editor = "nvim";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

    };
  };
}
