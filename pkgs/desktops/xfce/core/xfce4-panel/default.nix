{ lib
, mkXfceDerivation
, cairo
, exo
, garcon
, gobject-introspection
, gtk-layer-shell
, gtk3
, libdbusmenu-gtk3
, libwnck
, libxfce4ui
, libxfce4util
, libxfce4windowing
, tzdata
, vala
, wayland
, xfconf
}:

mkXfceDerivation {
  category = "xfce";
  pname = "xfce4-panel";
  version = "4.19.6";

  sha256 = "sha256-hREVkoS4Wng5CoN4GCXooS4KkFwkX79nSzS1wh0IhTA=";

  nativeBuildInputs = [
    gobject-introspection
    vala
  ];

  buildInputs = [
    cairo
    exo
    garcon
    gtk-layer-shell
    libdbusmenu-gtk3
    libxfce4ui
    libxfce4windowing
    libwnck
    tzdata
    wayland
    xfconf
  ];

  propagatedBuildInputs = [
    gtk3
    libxfce4util
  ];

  postPatch = ''
    substituteInPlace plugins/clock/clock.c \
       --replace-fail "/usr/share/zoneinfo" "${tzdata}/share/zoneinfo"
  '';

  meta = with lib; {
    description = "Panel for the Xfce desktop environment";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
