{
  lib,
  elixir,
  fetchFromGitHub,
  fetchMixDeps,
  mixRelease,
  nix-update-script,

  # for tests
  beam27Packages,
  beam28Packages,
}:
# Based on ../elixir-ls/default.nix

let
  pname = "ex_doc";
  version = "0.37.3";
  src = fetchFromGitHub {
    owner = "elixir-lang";
    repo = "${pname}";
    rev = "v${version}";
    hash = "sha256-2tam+3vYLC216Q78GIUI3fGnE5FJ/lECJAUQMSxz46w=";
  };
in
mixRelease {
  inherit
    pname
    version
    src
    elixir
    ;

  escriptBinName = "ex_doc";

  stripDebug = true;

  mixFodDeps = fetchMixDeps {
    pname = "mix-deps-${pname}";
    inherit src version elixir;
    hash = "sha256-s4b6wuBJPdN0FPn76zbLCHzqJNEZ6E4nOyB1whUM2VY=";
  };

  passthru = {
    tests = {
      # ex_doc is the doc generation for OTP 27+, so let's make sure they build
      erlang_27 = beam27Packages.erlang;
      erlang_28 = beam28Packages.erlang;
    };

    updateScript = nix-update-script { };
  };

  meta = with lib; {
    homepage = "https://github.com/elixir-lang/ex_doc";
    description = ''
      ExDoc produces HTML and EPUB documentation for Elixir projects
    '';
    license = licenses.asl20;
    platforms = platforms.unix;
    mainProgram = "ex_doc";
    maintainers = with maintainers; [ chiroptical ];
  };
}
