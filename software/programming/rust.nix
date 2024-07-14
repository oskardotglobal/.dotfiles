{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libgcc
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
