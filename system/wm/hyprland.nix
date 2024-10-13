{ pkgs, inputs, ... }:

{
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk # https://wiki.archlinux.org/title/XDG_Desktop_Portal > 4.3 Poor font rendering in GTK apps on KDE Plasma
    ];
  };
}
