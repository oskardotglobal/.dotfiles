{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      # Other
      "xcode-themes"
      "git-firefly"

      # Language support
      "nix"
      "deno"
      "basher"
      "elixir"
      "xml"
      "vue"
      "dockerfile"
      "docker-compose"
    ];

    extraPackages = with pkgs; [
      # nix
      nil

      # deno
      deno

      # basher
      shfmt
      shellcheck
      bash-language-server

      # elixir
      elixir_1_18

      # vue
      vue-language-server
      nodejs_22

      # docker
      dockerfile-language-server-nodejs
      docker-compose-language-service
    ];

    userSettings = {
      show_inline_completions = false;
      assistant.enabled = false;
      features.copilot = false;
      chat_panel.button = false;
      theme = "Xcode Classic Dark";
      base_keymap = "JetBrains";
      ui_font_size = 16;
      buffer_font_size = 16;
    };
  };
}
