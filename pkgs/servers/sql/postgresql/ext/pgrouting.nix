{
  boost,
  cmake,
  fetchFromGitHub,
  lib,
  perl,
  postgresql,
  postgresqlBuildExtension,
  stdenv,
}:

postgresqlBuildExtension (finalAttrs: {
  pname = "pgrouting";
  version = "3.7.3";

  nativeBuildInputs = [
    cmake
    perl
  ];
  buildInputs = [ boost ];

  src = fetchFromGitHub {
    owner = "pgRouting";
    repo = "pgrouting";
    tag = "v${finalAttrs.version}";
    hash = "sha256-jaevnDCJ6hRQeDhdAkvMTvnnFWElMNvo9gZRW53proQ=";
  };

  meta = {
    description = "PostgreSQL/PostGIS extension that provides geospatial routing functionality";
    homepage = "https://pgrouting.org/";
    changelog = "https://github.com/pgRouting/pgrouting/releases/tag/v${finalAttrs.version}";
    maintainers = with lib.maintainers; [ steve-chavez ];
    teams = [ lib.teams.geospatial ];
    platforms = postgresql.meta.platforms;
    license = lib.licenses.gpl2Plus;
  };
})
