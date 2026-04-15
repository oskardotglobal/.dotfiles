{ pkgs, nix-jetbrains-plugins, ... }:
with pkgs.jetbrains;
let
  ideaWithPlugins =
    let
      build = name: nix-jetbrains-plugins."${idea.pname}"."${idea.version}"."${name}";
    in
    [
      (build "net.antelle.intellij-xcode-dark-theme")

      # General
      (build "com.github.xepozz.gitattributes")
      (build "mobi.hsz.idea.gitignore")
      (build "org.mvnsearch.plugins.justPlugin")
      "wakatime"

      # Rust
      "rust"

      # Nix
      "nixidea"
      "better-direnv"

      # Python
      (build "insyncwithfoo.ryecharm")
      "python"

      # Minecraft
      "minecraft-development"
      (build "com.github.tth05.minecraft-nbt-intellij-plugin")
      (build "me.shedaniel.architectury")

      # Work
      (build "dev.ngocta.pycharm-odoo")
      (build "com.github.biomejs.intellijbiome")
      "graphql"
    ]
    |> plugins.addPlugins idea;
in
{
  environment.systemPackages = [ idea ];
}
