{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;

    themeFile = "xcodedark";
    darwinLaunchOptions = [ "--start-as=maximized" ];

    font = {
      name = "JetBrainsMono Nerd Font Mono";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 14;
    };

    keybindings = {
      "ctrl+space>h" = "move_window left";
      "ctrl+space>j" = "move_window bottom";
      "ctrl+space>k" = "move_window top";
      "ctrl+space>l" = "move_window right";
      "ctrl+space>c" = "new_tab";
      "ctrl+space>x" = "close_tab";
      "ctrl+space>b" = "next_tab";
      "ctrl+space>n" = "previous_tab";
      "ctrl+space>%" = "launch --cwd=current --location=vsplit";
      "ctrl+space>&" = "launch --cwd=current --location=hsplit";
    };

    settings = {
      enable_audio_bell = false;
      hide_window_decorations = true;
      enabled_layouts = "splits";
      macos_quit_when_last_window_closed = true;
    };
  };
}
