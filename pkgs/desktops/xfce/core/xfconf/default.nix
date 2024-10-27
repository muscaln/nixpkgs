{ lib
, mkXfceDerivation
, libxfce4util
, gobject-introspection
, vala
}:

mkXfceDerivation {
  category = "xfce";
  pname = "xfconf";
  version = "4.19.4";

  sha256 = "sha256-flUP7r5M85TH2xNcqaB2nekZekjX6nlbnmFX4dn4Ch4=";

  nativeBuildInputs = [ gobject-introspection vala ];

  buildInputs = [ libxfce4util ];

  meta = with lib; {
    description = "Simple client-server configuration storage and query system for Xfce";
    mainProgram = "xfconf-query";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
