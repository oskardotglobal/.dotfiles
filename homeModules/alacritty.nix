{
  pkgs,
  config,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = let
      family = "JetBrainsMono Nerd Font";
    in {
      terminal.shell = "${pkgs.tmux}/bin/tmux";
      font = {
        size = 14.0;
        normal = {
          inherit family;
          style = "Regular";
        };

        bold = {
          inherit family;
          style = "Bold";
        };

        italic = {
          inherit family;
          style = "Italic";
        };
      };

      window = {
        decorations = "None";
        startup_mode = "Maximized";
      };
    };
  };
}
