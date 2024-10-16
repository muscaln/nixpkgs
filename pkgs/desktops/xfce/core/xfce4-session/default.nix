{ lib
, mkXfceDerivation
, polkit
, exo
, libxfce4util
, libxfce4ui
, libxfce4windowing
, xfconf
, iceauth
, gtk3
, gtk-layer-shell
, glib
, libwnck
, xfce4-session
}:

mkXfceDerivation {
  category = "xfce";
  pname = "xfce4-session";
  version = "4.19.3-unstable-2024-11-06";
  rev = "268e2fc55372a6f02567fd2739d0ac8f2f155205";

  sha256 = "sha256-1z59ogvXV9P8BuMIgw2R0iJ7ZEsPTb+8KYV1k12qHlo=";

  buildInputs = [
    exo
    gtk3
    gtk-layer-shell
    glib
    libxfce4ui
    libxfce4util
    libxfce4windowing
    libwnck
    xfconf
    polkit
    iceauth
  ];

  configureFlags = [
    "--with-xsession-prefix=${placeholder "out"}"
    "--with-wayland-session-prefix=${placeholder "out"}"
  ];

  passthru.xinitrc = "${xfce4-session}/etc/xdg/xfce4/xinitrc";

  meta = with lib; {
    description = "Session manager for Xfce";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
