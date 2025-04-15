{pkgs, ...}: {
  home.packages = [
    (pkgs.lutris.override {
      extraPkgs = pkgs: [
        # List library dependencies here
        pkgs.wine
        pkgs.umu-launcher
        pkgs.mangohud
      ];
    })
  ];
}
