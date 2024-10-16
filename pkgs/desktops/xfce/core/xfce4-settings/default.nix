{ lib
, mkXfceDerivation
, wayland-scanner
, exo
, garcon
, gtk3
, gtk-layer-shell
, glib
, libnotify
, libxfce4ui
, libxfce4util
, libxklavier
, upower
, withUpower ? true
, wlr-protocols
, xfconf
, xf86inputlibinput
, colord
, withColord ? true
}:

mkXfceDerivation {
  category = "xfce";
  pname = "xfce4-settings";
  version = "4.19.3";

  sha256 = "sha256-IY93O4yuZaX2Pxg27V8J5O/jcryilDm3GIHzlikeWsM=";

  nativeBuildInputs = [
    wayland-scanner
  ];

  buildInputs = [
    exo
    garcon
    glib
    gtk3
    gtk-layer-shell
    libnotify
    libxfce4ui
    libxfce4util
    libxklavier
    wlr-protocols
    xf86inputlibinput
    xfconf
  ]
  ++ lib.optionals withUpower [ upower ]
  ++ lib.optionals withColord [ colord ];

  configureFlags = [
    "--enable-pluggable-dialogs"
    "--enable-sound-settings"
  ]
  ++ lib.optionals withUpower [ "--enable-upower-glib" ]
  ++ lib.optionals withColord [ "--enable-colord" ];

  meta = with lib; {
    description = "Settings manager for Xfce";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
