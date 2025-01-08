{...}: {
  # Used by gmodena/nix-flatpak for declarative management
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    packages = [
      "com.github.tchx84.Flatseal"
      # Check Arch Wiki if rich presence does not work
      "com.discordapp.Discord"
      "info.portfolio_performance.PortfolioPerformance"
      "com.calibre_ebook.calibre"
      "org.qbittorrent.qBittorrent"
    ];
  };
}
