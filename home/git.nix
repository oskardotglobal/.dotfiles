{...}: {
  programs.git = {
    userName = "Oskar Manhart";
    userEmail = "52569953+oskardotglobal@users.noreply.github.com";

    aliases = {
      slog = "log --graph --all --topo-order --pretty='format:%h %ai %s%d (%an)'";
    };

    extraConfig = {
      init.defaultBranch = "main";

      core = {
        abbrev = 8;
        eol = "lf";
        autocrlf = false;
      };

      pull.rebase = false;
    };
  };
}
