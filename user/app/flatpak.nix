{ config, pkgs, ... }:

{
  services.flatpak.packages = [
    "net.lutris.Lutris"
    # Check Arch Wiki if rich presence does not work
    "com.discordapp.Discord"
    "info.portfolio_performance.PortfolioPerformance"
    # Check if gamepads are not working
    # https://github.com/flathub/com.valvesoftware.Steam/wiki#my-controller-isnt-being-detected
    "com.valvesoftware.Steam"
    "com.calibre_ebook.calibre"
    "org.qbittorrent.qBittorrent"
    "org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08" # this branch supports Lutris integration
  ];
  
  # Used by gmodena/nix-flatpak for declarative management
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
