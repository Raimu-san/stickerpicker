let pkgs = import <nixpkgs> {};
    cryptg = pkgs.python38Packages.buildPythonPackage rec {
    pname = "cryptg";
    version = "0.2.post0";

    src = pkgs.python38Packages.fetchPypi {
      inherit pname version;
      sha256 = "06z0v77bcm8wmlhq4xjjbbnq7g7wc8s1ldc4gx0jqs8zys1c10if";
    };

    propagatedBuildInputs = with pkgs.python38Packages; [ cffi pycparser ];

    doCheck = false;
  };

in pkgs.mkShell {
  buildInputs = with pkgs.python38Packages; [
    setuptools aiohttp yarl pillow telethon cryptg python_magic pip
  ];
  shellHook = ''
            export PIP_PREFIX=$(pwd)/_build/pip_packages
            export PYTHONPATH="$PIP_PREFIX/${pkgs.python38.sitePackages}:$PYTHONPATH"
            export PATH="$PIP_PREFIX/bin:$PATH"
            unset SOURCE_DATE_EPOCH
  '';
}
