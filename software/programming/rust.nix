{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rustup
    (
      rust-bin.selectLatestNightlyWith (
        toolchain:
          toolchain.default.override {
            extensions = ["rust-src"];
            targets = ["wasm32-unknown-unknown"];
          }
      )
    )
  ];
}
