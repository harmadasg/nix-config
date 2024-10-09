{ pkgs, inputs, ... }:

{
  # Configure keymap in X11
  services.xserver.xkb.layout = "us,hu";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    discover
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk # https://wiki.archlinux.org/title/XDG_Desktop_Portal > 4.3 Poor font rendering in GTK apps on KDE Plasma
    ];
  };
}
