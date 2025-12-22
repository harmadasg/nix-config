{pkgs, ...}: {
  # should use lutris module instead
  home.packages = [
    (pkgs.lutris.override {
      extraPkgs = pkgs: [
        # List library dependencies here
        pkgs.wine
        pkgs.umu-launcher
        pkgs.mangohud
      ];
      lutris-unwrapped = pkgs.lutris-unwrapped.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            (pkgs.fetchpatch {
              url = "https://github.com/lutris/lutris/pull/6301.patch";
              hash = "sha256-96r808hWgRrzrqdPB5SSWABP0I00LiNgqxfYaVCqSRk=";
            })
          ];
      });
    })
  ];
}
