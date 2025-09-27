{
  pkgs ? import <nixpkgs> { },
  extraPackages ? [ ],
}:
pkgs.symlinkJoin {
  name = "hx";
  paths = [ pkgs.helix ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/hx \
        --prefix PATH : ${pkgs.lib.makeBinPath extraPackages}
  '';
}
