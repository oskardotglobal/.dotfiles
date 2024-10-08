final: prev: {
  python3 = prev.python3.override {
    # Careful, we're using a different final and prev here!
    packageOverrides = pyfinal: pyprev: {
      inputs = pyprev.buildPythonPackage rec {
        pname = "inputs";
        version = "0.5";
        format = "setuptools";

        src = pyprev.fetchPypi {
          inherit pname version;
          hash = "sha256-ox1blqNSXxIy8ya+nnzozK+HPGsfuE2fPJvD15sj6uQ=";
        };

        doCheck = false;
        pythonImportsCheck = ["inputs"];
      };

      steam = pyprev.buildPythonPackage rec {
        pname = "steam";
        version = "1.4.4";
        format = "setuptools";

        src = pyprev.fetchPypi {
          inherit pname version;
          hash = "sha256-K1vWkRwNSnMS9EG40WK52NR8i+u478bIhnOTsDI/pS4=";
        };

        doCheck = false;
        pythonImportsCheck = ["steam"];
      };
    };
  };

  python3Packages = final.python3.pkgs;

  protonup-qt = final.qt6Packages.callPackage ({
    python3Packages,
    wrapQtAppsHook,
    fetchFromGitHub,
    qt6,
  }:
    python3Packages.buildPythonApplication rec {
      pname = "protonup-qt";
      version = "2.10.2";
      format = "pyproject";

      nativeBuildInputs = [
        wrapQtAppsHook
        python3Packages.setuptools
      ];

      buildInputs = [
        qt6.qtbase
      ];

      dontWrapQtApps = true;

      propagatedBuildInputs = with python3Packages; [
        pyside6
        requests
        vdf
        inputs
        pyxdg
        steam
        pyyaml
        zstandard
      ];

      src = fetchFromGitHub {
        owner = "DavidoTek";
        repo = "ProtonUp-Qt";
        rev = "v${version}";
        hash = "sha256-hf0ZLvn5mv0BlUgMvDwpdsa9ye3Bz47n0aSz+jgBrXg=";
      };

      postPatch = ''
        sed -i "s/PyYAML==6.0$/PyYAML/" setup.cfg
        sed -i "s/PySide6-Essentials>=6.3.0$/PySide6/" setup.cfg
      '';

      preFixup = ''
        qtWrapperArgs+=("''${gappsWrapperArgs[@]}")
        # You can manually patch scripts using: wrapQtApp "$out/bin/myapp". TODO: check when it's required.
      '';
    }) {};
}
