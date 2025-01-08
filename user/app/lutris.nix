{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  umu = inputs.umu.packages.${system}.umu.override {
    version = inputs.umu.shortRev;
    truststore = true;
    cbor2 = true;
  };
in {
  home.packages = [
    (pkgs.lutris.override {
      extraPkgs = pkgs: [
        # List library dependencies here
        pkgs.wine
        umu
      ];
    })
  ];
}
