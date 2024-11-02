{ lib, mkXfceDerivation, exo, librsvg, dbus-glib, libepoxy, gtk3, libXdamage
, libstartup_notification, libxfce4ui, libxfce4util, libwnck
, libXpresent, xfconf }:

mkXfceDerivation {
  category = "xfce";
  pname = "xfwm4";
  version = "4.19.0";

  sha256 = "sha256-PG9VVQ8go3CiBoKOTQHm3K5YI9Xy+ARo+9ckkEfCwTk=";

  nativeBuildInputs = [ exo librsvg ];

  buildInputs = [
    dbus-glib
    libepoxy
    gtk3
    libXdamage
    libstartup_notification
    libxfce4ui
    libxfce4util
    libwnck
    libXpresent
    xfconf
  ];

  meta = with lib; {
    description = "Window manager for Xfce";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
