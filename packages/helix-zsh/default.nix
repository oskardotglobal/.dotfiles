{
  lib,
  fetchFromGitHub,
  rustPlatform,
  stdenv,
  helix,
}:

let
  pname = "helix-driver";
  version = "0.1.0-unstable-2026-05-16";

  src = fetchFromGitHub {
    owner = "john-h-k";
    repo = "helix-zsh";
    rev = "main";
    hash = "sha256-ZbRUoKqaMfagOZFuj+csdcsV1oAOtf9s6XqRGtOcfmc=";
  };
in
rustPlatform.buildRustPackage {
  inherit pname version src;

  cargoHash = "sha256-fS4WEV02FisHKEi6WBeo9FqtCeaIeXjR9/PrDeCtTps=";
  cargoRoot = "helix-driver";
  buildAndTestSubdir = "helix-driver";

  HELIX_DISABLE_AUTO_GRAMMAR_BUILD = 1;

  preBuild = ''
    for f in languages.toml theme.toml base16_theme.toml; do
      ln -s ${helix.src}/$f "$NIX_BUILD_TOP/${pname}-${version}-vendor/$f"
    done
  '';

  postInstall = ''
    mkdir -p $out
    cp ${./plugin.zsh} $out/helix-zsh.plugin.zsh

    ${lib.optionalString (!stdenv.isDarwin) ''
      substituteInPlace $out/helix-zsh.plugin.zsh \
        --replace-fail "pbcopy" "xclip -selection clipboard"
    ''}
  '';

  meta = with lib; {
    description = "Helix editor keybindings for zsh shell";
    homepage = "https://github.com/john-h-k/helix-zsh";
    license = licenses.mit;
    maintainers = [ ];
  };
}
