{ lib, mkXfceDerivation, exo, gtk3, libgudev, libxfce4ui, libxfce4util, xfconf }:

mkXfceDerivation {
  category = "xfce";
  pname = "thunar-volman";
  version = "4.19.0";

  buildInputs = [ exo gtk3 libgudev libxfce4ui libxfce4util xfconf ];

  sha256 = "sha256-7sLBvL1TyyMLGeFAs8MPvM+aSwEaziTuJs/Hccwl5P0=";

  odd-unstable = false;

  meta = with lib; {
    description = "Thunar extension for automatic management of removable drives and media";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
