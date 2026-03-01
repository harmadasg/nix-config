{pkgs, ...}: {
  # TODO remove this workaround
  home.packages = [
    (pkgs.calibre.overrideAttrs (old: {
      installPhase = ''
        export QMAKE="${pkgs.qt6.qtbase}/bin/qmake"

        ${old.installPhase}
      '';
    }))
  ];
}
