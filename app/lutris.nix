{ config, pkgs, ... }:

{
  services.flatpak.packages = [
    "net.lutris.Lutris"
  ];
}
