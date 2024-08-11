final: prev: {
  spotify = prev.spotify.overrideAttrs (old: {
    srcs = [
      old.src
      (prev.fetchurl {
        url = "https://github.com/SpotX-Official/SpotX-Bash/raw/392aee45d9d22dd5d8404e1c5f5fed45890a4619/spotx.sh";
        hash = "sha256-ekWDilj1v/9P0Jlos2ZnAQk7IyfrX/rhcmSMQIA23wo=";
      })
    ];

    nativeBuildInputs = old.nativeBuildInputs ++ [prev.util-linux prev.perl prev.unzip prev.zip];

    unpackPhase =
      builtins.replaceStrings
      [
        "unsquashfs \"$src\" '/usr/share/spotify' '/usr/bin/spotify' '/meta/snap.yaml'"
        "runHook postInstall"
      ]
      [
        ''
          unsquashfs "$(echo $srcs | awk '{print $1}')" '/usr/share/spotify' '/usr/bin/spotify' '/meta/snap.yaml'
          patchShebangs --build "$(echo $srcs | awk '{print $2}')"
        ''
        ''
          bash "$(echo $srcs | awk '{print $2}')" -f -P "$out/share/spotify"
          runHook postInstall
        ''
      ]
      old.unpackPhase;
  });
}
