<<<<<<< HEAD
{ ... }:
{
=======
_: {
>>>>>>> 3cae6793b840d17c4827a03172e681b3b3389ae0
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
