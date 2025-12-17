{ pkgs, ... }:
{
  home.file."/.config/helix/languages.toml".text = ''
    [[language]]
    name = "nix"
    auto-format = true

    [[language]]
    name = "c"
    auto-format = true

    # [language-server.clangd]
    # args = ["-fallback-style={BasedOnStyle: WebKit, IndentWidth: 4}"]
  '';

  programs.helix = {
    enable = true;
    defaultEditor = true;

    package = import ../packages/helix.nix {
      inherit pkgs;
      extraPackages = with pkgs; [
        perl540Packages.PerlTidy
        perlnavigator
        nixfmt-rfc-style
        nixd
      ];
    };

    settings =
      let
        noArrows = {
          left = "no_op";
          right = "no_op";
          up = "no_op";
          down = "no_op";
        };
      in
      {
        theme = "xcode_dark";
        editor.mouse = false;

        keys = {
          normal = noArrows;
          insert = noArrows;
        };
      };

    themes."xcode_dark" = {
      # Xcode Dark theme
      # Based on: https://;github.com/sdev138/Helix-xcode-theme
      # License: GPLv3

      # UI elements
      "ui.background".bg = "bg";
      "ui.text".fg = "fg";
      "ui.cursor".modifiers = [ "reversed" ];
      "ui.cursor.match" = {
        fg = "constant-fg";
        modifiers = [ "bold" ];
      };
      "ui.cursorline.primary".bg = "cursor-line";
      "ui.selection".bg = "selection-bg";
      "ui.selection.primary".bg = "selection-bg";
      "ui.help" = {
        bg = "bg";
        fg = "fg";
      };
      "ui.linenr".fg = "fg-gutter";
      "ui.linenr.selected".fg = "fg";
      "ui.menu" = {
        bg = "bg";
        fg = "fg";
      };
      "ui.menu.selected".bg = "selection-bg";
      "ui.popup".bg = "bg";
      "ui.statusline" = {
        bg = "bg";
        fg = "fg";
      };
      "ui.statusline.inactive" = {
        bg = "bg";
        fg = "comment-fg";
      };
      "ui.virtual.whitespace".fg = "fg-gutter";
      "ui.window".fg = "fg";

      # Syntax highlighting;
      "comment" = {
        fg = "comment-fg";
        modifiers = [ "italic" ];
      };
      "constant".fg = "constant-fg";
      "string".fg = "string-fg";
      "variable".fg = "fg";
      "type".fg = "type-fg";
      "function".fg = "function-fg";
      "keyword".fg = "keyword-fg";
      "operator".fg = "fg";
      "namespace".fg = "type-fg";

      # Diagnostics;
      "diagnostic.error".underline = {
        style = "curl";
        color = "error-fg";
      };
      "diagnostic.warning".underline = {
        style = "curl";
        color = "warning-fg";
      };
      "diagnostic.info".underline = {
        style = "curl";
        color = "info-fg";
      };
      "diagnostic.hint".underline = {
        style = "curl";
        color = "hint-fg";
      };

      palette = {
        bg = "#292A30";
        fg = "#DFDFE0";
        selection-bg = "#436595";
        cursor-line = "#2F3239";
        comment-fg = "#7F8C98";
        string-fg = "#FF8170";
        keyword-fg = "#FF7AB2";
        function-fg = "#DAB5FF";
        constant-fg = "#D9C97C";
        type-fg = "#6BDFFF";
        warning-fg = "#FFB157";
        error-fg = "#FF3B30";
        info-fg = "#6BDFFF";
        hint-fg = "#7F8C98";
        fg-gutter = "#53606E";
      };
    };
  };
}
