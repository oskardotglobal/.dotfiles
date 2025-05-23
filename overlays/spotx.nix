final: prev:
let
  spotx = prev.fetchurl {
    url = "https://github.com/SpotX-Official/SpotX-Bash/raw/d756a3f23ddd8bbbeb644f6070a147aaa239ba4a/spotx.sh";
    hash = "sha256-7YW4yaIgamuKrdKpjPEwFqnCWX+9pGvvVYvwGySR9VA=";
  };
in
{
  spotify = prev.spotify.overrideAttrs (old: {
    nativeBuildInputs =
      old.nativeBuildInputs
      ++ (with prev; [
        util-linux
        perl
        unzip
        zip
        curl
      ]);

    unpackPhase =
      builtins.replaceStrings
        [ "runHook postUnpack" ]
        [
          ''
            patchShebangs --build ${spotx}
            runHook postUnpack
          ''
        ]
        old.unpackPhase;

    installPhase =
      builtins.replaceStrings
        [ "runHook postInstall" ]
        [
          ''
            bash ${spotx} -f -P "$out/share/spotify"
            runHook postInstall
          ''
        ]
        old.installPhase;
  });
}
