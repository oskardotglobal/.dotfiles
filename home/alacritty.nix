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
      shell = "${pkgs.tmux}/bin/tmux";
      font = {
        size = 13.0;
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
    };
  };
}
