{ lib
, mkXfceDerivation
, wayland-scanner
, gtk3
, libnotify
, libxfce4ui
, libxfce4util
, polkit
, upower
, wayland-protocols
, wlr-protocols
, xfconf
, xfce4-panel
}:

mkXfceDerivation {
  category = "xfce";
  pname = "xfce4-power-manager";
  version = "4.19.4";

  sha256 = "sha256-Lo2aGEB935zpI+bJb3N6n3bJIB8Hl2bJgdeF62yHE9s=";

  nativeBuildInputs = [
    wayland-scanner
  ];

  buildInputs = [
    gtk3
    libnotify
    libxfce4ui
    libxfce4util
    polkit
    upower
    wayland-protocols
    wlr-protocols
    xfconf
    xfce4-panel
  ];

  # using /run/current-system/sw/bin instead of nix store path prevents polkit permission errors on
  # rebuild.  See https://github.com/NixOS/nixpkgs/issues/77485
  postPatch = ''
    substituteInPlace src/org.xfce.power.policy.in.in --replace-fail "@sbindir@" "/run/current-system/sw/bin"
    substituteInPlace common/xfpm-brightness-polkit.c --replace-fail "SBINDIR" "\"/run/current-system/sw/bin\""
    substituteInPlace src/xfpm-suspend.c --replace-fail "SBINDIR" "\"/run/current-system/sw/bin\""
  '';

  meta = with lib; {
    description = "Power manager for the Xfce Desktop Environment";
    maintainers = with maintainers; [ ] ++ teams.xfce.members;
  };
}
