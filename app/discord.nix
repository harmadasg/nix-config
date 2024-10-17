{ config, pkgs, ... }:

{
  # Check Arch Wiki if rich presence does not work
  services.flatpak.packages = [
    "com.discordapp.Discord"
  ];
}
