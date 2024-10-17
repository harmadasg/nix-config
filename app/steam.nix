{ config, pkgs, ... }:

{
  # Check if gamepads are not working
  # https://github.com/flathub/com.valvesoftware.Steam/wiki#my-controller-isnt-being-detected
  services.flatpak.packages = [
    "com.valvesoftware.Steam"
  ];
}
