{ lib
, mkXfceDerivation
, exo
, gtk3
, libcanberra
, libpulseaudio
, libnotify
, libxfce4ui
, libxfce4util
, libxfce4windowing
, xfce4-panel
, xfconf
, keybinder3
, glib
}:

mkXfceDerivation {
  category = "panel-plugins";
  pname = "xfce4-pulseaudio-plugin";
  version = "0.4.8-unstable-2024-11-12";
  rev = "97c072d86ea0ed2e6f831657f1617ef27d073e6e";
  sha256 = "sha256-EhsuwGTfqTGeQoW8eRLbzyn96ESDFXceYX5wQUTOt5Q=";

  buildInputs = [
    exo
    glib
    gtk3
    keybinder3
    libcanberra
    libnotify
    libpulseaudio
    libxfce4ui
    libxfce4util
    libxfce4windowing
    xfce4-panel
    xfconf
  ];

  meta = with lib; {
    description = "Adjust the audio volume of the PulseAudio sound system";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
