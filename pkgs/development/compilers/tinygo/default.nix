{ stdenv
, lib
, buildPackages
, buildGoModule
, fetchFromGitHub
, makeWrapper
, substituteAll
, llvmPackages
, go
, libffi
, zlib
, ncurses
, libxml2
, xar
, wasi-libc
, binaryen
, avrdude
, gdb
, openocd
, tinygoTests ? [ "smoketest" ]
}:

let
  inherit (llvmPackages) llvm clang compiler-rt lld;
in

buildGoModule rec {
  pname = "tinygo";
  version = "0.28.1";

  src = fetchFromGitHub {
    owner = "tinygo-org";
    repo = "tinygo";
    rev = "v${version}";
    sha256 = "kmmlLxXdkaIrUVV1Ty/5nrhCJOffhaM03YTlvily+mA=";
    fetchSubmodules = true;
  };

  vendorSha256 = "sha256-J58H0xwAmdUfbFDjaUqfqG3N/ATxtx8nEknatNu1s54=";

  patches = [
    ./0001-Makefile.patch

    (substituteAll {
      src = ./0002-Add-clang-header-path.patch;
      clang_include = "${clang.cc.lib}/lib/clang/${clang.cc.version}/include";
    })

    #TODO(muscaln): Find a better way to fix build ID on darwin
    ./0003-Use-out-path-as-build-id-on-darwin.patch
  ];

  nativeCheckInputs = [ binaryen clang.cc lld gdb ];
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ llvm clang.cc ]
    ++ lib.optionals stdenv.isDarwin [ zlib ncurses libffi libxml2 xar ];

  doCheck = (stdenv.buildPlatform.canExecute stdenv.hostPlatform);
  inherit tinygoTests;

  allowGoReference = true;
  tags = [ "llvm${lib.versions.major llvm.version}" ];
  ldflags = [ "-X github.com/tinygo-org/tinygo/goenv.TINYGOROOT=${placeholder "out"}/share/tinygo" ];
  subPackages = [ "." ];

  # Output contains static libraries for different arm cpus
  # and stripping could mess up these so only strip the compiler
  stripDebugList = [ "bin" ];

  postConfigure = lib.optionalString stdenv.isDarwin ''
    for i in vendor/tinygo.org/x/go-llvm/llvm_config_darwin*; do
      substituteInPlace $i --replace "curses" "ncurses"
    done
  '';

  postPatch = ''
    # Copy wasi-libc, symlink seems not working
    rm -rf lib/wasi-libc/*
    mkdir -p lib/wasi-libc/sysroot/lib/wasm32-wasi lib/wasi-libc/sysroot/include
    cp -a ${wasi-libc}/lib/* lib/wasi-libc/sysroot/lib/wasm32-wasi/
    cp -a ${wasi-libc.dev}/include/* lib/wasi-libc/sysroot/include/

    # Borrow compiler-rt builtins from our source
    # See https://github.com/tinygo-org/tinygo/pull/2471
    mkdir -p lib/compiler-rt-builtins
    cp -a ${compiler-rt.src}/compiler-rt/lib/builtins/* lib/compiler-rt-builtins/

    substituteInPlace Makefile \
      --replace "\$(TINYGO)" "$(pwd)/build/tinygo" \
      --replace "@\$(MD5SUM)" "md5sum" \
      --replace "build/release/tinygo/bin" "$out/bin" \
      --replace "build/release/" "$out/share/"

    # Darwin patch
    substituteInPlace builder/buildid.go \
      --replace "OUT_PATH" "$out"

    substituteInPlace compileopts/target.go \
      --replace "gdb-multiarch" "gdb"

    # TODO: Fix mingw and darwin
    # Disable windows and darwin cross-compile tests
    sed -i "/GOOS=windows/d" Makefile
    sed -i "/GOOS=darwin/d" Makefile
  '' + lib.optionalString (stdenv.buildPlatform != stdenv.hostPlatform) ''
    substituteInPlace Makefile \
      --replace "./build/tinygo" "${buildPackages.tinygo}/bin/tinygo"
  '';

  preBuild = ''
    export HOME=$TMPDIR
  '';

  postBuild = let
    tinygoForBuild = if (stdenv.buildPlatform.canExecute stdenv.hostPlatform)
      then "build/tinygo"
      else "${buildPackages.tinygo}/bin/tinygo";
    in ''
    # Move binary
    mkdir -p build
    mv $GOPATH/bin/tinygo build/tinygo

    make gen-device

    export TINYGOROOT=$(pwd)
    finalRoot=$out/share/tinygo

    for target in thumbv6m-unknown-unknown-eabi-cortex-m0 thumbv6m-unknown-unknown-eabi-cortex-m0plus thumbv7em-unknown-unknown-eabi-cortex-m4; do
      mkdir -p $finalRoot/pkg/$target
      for lib in compiler-rt picolibc; do
        ${tinygoForBuild} build-library -target=''${target#*eabi-} -o $finalRoot/pkg/$target/$lib $lib
      done
    done
  '';

  checkPhase = lib.optionalString (tinygoTests != [ ] && tinygoTests != null) ''
    make ''${tinygoTests[@]} XTENSA=0
  '';

  installPhase = ''
    runHook preInstall

    make build/release

    wrapProgram $out/bin/tinygo \
      --prefix PATH : ${lib.makeBinPath [ clang.cc lld go gdb avrdude openocd binaryen ]}

    runHook postInstall
  '';

  disallowedReferences = [ wasi-libc ];

  meta = with lib; {
    homepage = "https://tinygo.org/";
    description = "Go compiler for small places";
    license = licenses.bsd3;
    maintainers = with maintainers; [ Madouura muscaln ];
  };
}
