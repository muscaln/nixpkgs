{ lib, mkXfceDerivation, exo, garcon, gtk3, libxfce4util, libxfce4ui, xfconf }:

mkXfceDerivation {
  category = "xfce";
  pname = "xfce4-appfinder";
  version = "4.19.3";

  sha256 = "sha256-1rTD/PgS2qWBlnwZlP5Klp+fjWAHHoPHETvCT/4BvaQ=";

  nativeBuildInputs = [ exo ];
  buildInputs = [ garcon gtk3 libxfce4ui libxfce4util xfconf ];

  meta = with lib; {
    description = "Appfinder for the Xfce4 Desktop Environment";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
