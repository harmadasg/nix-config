{
  lib,
  config,
  ...
}: let
  steam = "com.valvesoftware.Steam";
in {
  services.flatpak.packages = [
    "net.lutris.Lutris"
    # Check Arch Wiki if rich presence does not work
    "com.discordapp.Discord"
    "info.portfolio_performance.PortfolioPerformance"
    steam
    "com.calibre_ebook.calibre"
    "org.qbittorrent.qBittorrent"
    "org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08" # this branch supports Lutris integration
    "org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08" # this branch supports Steam integration
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

  # Workaround needed because flatpak shouldn't access symlinks from nix store
  # Only needed until the fix is available https://github.com/lutris/lutris/issues/5455
  home.activation.createSteamSymlink = let
    homeDir = config.home.homeDirectory;
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf ${homeDir}/.var/app/${steam}/.steam ${homeDir}/.steam
    '';
}

