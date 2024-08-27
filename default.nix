final: prev: {
  spotify = prev.spotify.overrideAttrs (old: {
    srcs = [
      old.src
      (prev.fetchurl {
        url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/67e2e1db68b082c57398602720886489781e7dd3/spotx.sh";
        hash = "sha256-P4sCZcX4K7U/5Ha6EfqTvAMMU0ex5/3vSRLA/RfZaD0=";
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
