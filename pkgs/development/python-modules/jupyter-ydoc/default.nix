{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  hatch-nodejs-version,
  hatchling,

  # dependencies
  pycrdt,
  pytestCheckHook,

  # tests
  websockets,
  ypy-websocket,
}:

buildPythonPackage rec {
  pname = "jupyter-ydoc";
  version = "3.0.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "jupyter-server";
    repo = "jupyter_ydoc";
    tag = "v${version}";
    hash = "sha256-dD4ZLT5yKGdvWnsPd3nAKmi6Ca+MK5f/ufyNfbGMmoM=";
  };

  build-system = [
    hatch-nodejs-version
    hatchling
  ];

  dependencies = [ pycrdt ];

  pythonImportsCheck = [ "jupyter_ydoc" ];

  nativeCheckInputs = [
    pytestCheckHook
    websockets
    ypy-websocket
  ];

  # requires a Node.js environment
  doCheck = false;

  meta = {
    changelog = "https://github.com/jupyter-server/jupyter_ydoc/blob/v${version}/CHANGELOG.md";
    description = "Document structures for collaborative editing using Ypy";
    homepage = "https://github.com/jupyter-server/jupyter_ydoc";
    license = lib.licenses.bsd3;
    teams = [ lib.teams.jupyter ];
  };
}
