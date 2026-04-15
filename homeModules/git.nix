{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;

      settings = {
        user = {
          name = "Oskar Manhart";
          email = "52569953+oskardotglobal@users.noreply.github.com";
        };

        aliases.slog = "log --graph --all --topo-order --pretty='format:%h %ai %s%d (%an)'";
        init.defaultBranch = "main";
        pull.rebase = false;

        core = {
          abbrev = 8;
          eol = "lf";
          autocrlf = false;
        };
      };
    };

    difftastic = {
      enable = true;
      git.enable = true;
    };
  };
}
