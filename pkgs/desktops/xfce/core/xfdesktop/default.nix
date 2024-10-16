{
  lib,
  mkXfceDerivation,
  exo,
  gtk3,
  libxfce4ui,
  libxfce4util,
  libxfce4windowing,
  libyaml,
  xfconf,
  libnotify,
  garcon,
  gtk-layer-shell,
  thunar,
}:

mkXfceDerivation {
  category = "xfce";
  pname = "xfdesktop";
  version = "4.19.6";

  sha256 = "sha256-XKgejqWuSjGYLDWv1NAWhcXpLt+i2z3Z6t5I6kWen4Y=";

  buildInputs = [
    exo
    gtk3
    libxfce4ui
    libxfce4util
    libxfce4windowing
    libyaml
    xfconf
    libnotify
    garcon
    gtk-layer-shell
    thunar
  ];

  meta = with lib; {
    description = "Xfce's desktop manager";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
