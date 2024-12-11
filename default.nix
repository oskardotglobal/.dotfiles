final: prev: let
  spotx = prev.fetchurl {
    url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/9b8e3a6c443f5bde5803505105a569fac8510668/spotx.sh";
    hash = "sha256-vry/wB5mcQUNeUUwwipzGwsZhxOJYJkc2w5z9vmcRdE=";
  };
in {
  spotify = prev.spotify.overrideAttrs (old: {
    nativeBuildInputs = old.nativeBuildInputs ++ (with prev; [util-linux perl unzip zip curl]);

    unpackPhase =
      builtins.replaceStrings
      [
        "unsquashfs \"$src\" '/usr/share/spotify' '/usr/bin/spotify' '/meta/snap.yaml'"
      ]
      [
        ''
          unsquashfs "$src" '/usr/share/spotify' '/usr/bin/spotify' '/meta/snap.yaml'
          patchShebangs --build ${spotx}
        ''
      ]
      old.unpackPhase;

    installPhase =
      builtins.replaceStrings
      ["runHook postInstall"]
      [
        ''
          bash ${spotx} -f -P "$out/share/spotify"
          runHook postInstall
        ''
      ]
      old.installPhase;
  });
}
