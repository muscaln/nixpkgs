{ lib, mkXfceDerivation, docbook_xsl, glib, libxslt, gtk3
, libxfce4ui, libxfce4util, perl }:

mkXfceDerivation {
  category = "xfce";
  pname = "exo";
  version = "4.19.1";

  sha256 = "sha256-GkryGsbvkOPlRimzE/5WXWRFqOIj9/Midq6Gal0b7DE=";

  nativeBuildInputs = [
    libxslt
    docbook_xsl
  ];

  buildInputs = [
    gtk3
    glib
    libxfce4ui
    libxfce4util
    (perl.withPackages(ps: with ps; [ URI ])) # for $out/lib/xfce4/exo/exo-compose-mail
  ];

  meta = with lib; {
    description = "Application library for Xfce";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
