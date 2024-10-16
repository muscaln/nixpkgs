{
  mkXfceDerivation,
  lib,
  gobject-introspection,
  vala,
  glib,
}:

mkXfceDerivation {
  category = "xfce";
  pname = "libxfce4util";
  version = "4.19.4";

  sha256 = "sha256-HfmmUo1RWQao92GaLOQAgdm9z2wljVpuwDl+veTWS7g=";

  nativeBuildInputs = [
    gobject-introspection
    vala
  ];

  propagatedBuildInputs = [
    glib
  ];

  meta = with lib; {
    description = "Extension library for Xfce";
    mainProgram = "xfce4-kiosk-query";
    license = licenses.lgpl2Plus;
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
