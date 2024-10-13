final: prev: {
  git-blame-someone-else = prev.stdenv.mkDerivation rec {
    pname = "git-blame-someone-else";
    version = "0-unstable-2018-06-13";

    src = prev.fetchFromGitHub {
      owner = "jayphelps";
      repo = "git-blame-someone-else";

      rev = "8d854c2d78cb98afdb9f5a73240e06393260b327";
      hash = "sha256-xraG1dR5Q8oDlUXARgh0ql8eRwH4bJWblJFjH1wJcys=";
    };

    nativeBuildInputs = [prev.makeWrapper];
    buildInputs = [prev.gitFull prev.perl];

    installPhase = ''
      runHook preInstall

      mkdir -p $out

      install -m755 -D git-blame-someone-else $out/bin/git-blame-someone-else
      wrapProgram $out/bin/git-blame-someone-else \
        --prefix PATH : "${prev.lib.makeBinPath buildInputs}"

      runHook postInstall
    '';
  };
}
