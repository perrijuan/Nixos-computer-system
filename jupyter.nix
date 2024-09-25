with import <nixpkgs> { };

let
  pythonPackages = python310Packages; # Altere para Python 3.10
in pkgs.mkShell rec {
  name = "impurePythonEnv";
  venvDir = "./.venv";
  buildInputs = [

    pkgs.stdenv.cc.cc.lib

    git-crypt
    # stdenv.cc.cc # jupyter lab needs

    # pythonPackages.python
    pythonPackages.ipykernel
    pythonPackages.jupyterlab
    pythonPackages.pyzmq    # Adicionando pyzmq explicitamente
    pythonPackages.venvShellHook
    pythonPackages.pip
    pythonPackages.numpy
    pythonPackages.pandas
    pythonPackages.requests

    # às vezes você pode precisar de algo adicional como o seguinte - você receberá algum erro útil se estiver procurando por um binário no ambiente.
    taglib
    openssl
    git
    libxml2
    libxslt
    libzip
    zlib

  ];

  # Execute este comando, somente após criar o ambiente virtual
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    
    python -m ipykernel install --user --name=myenv4 --display-name="myenv4"
    pip install -r requirements.txt
  '';

  # Agora podemos executar quaisquer comandos dentro do ambiente virtual.
  # Isso é opcional e pode ser omitido para executar o pip manualmente.
  postShellHook = ''
    # permitir que o pip instale rodas
    unset SOURCE_DATE_EPOCH
  '';
}
