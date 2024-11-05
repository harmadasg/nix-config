{ config, pkgs, ... }:

{
  # Used by gmodena/nix-flatpak for declarative management
  services.flatpak.enable = true;
  xdg.portal.enable = true;
}
