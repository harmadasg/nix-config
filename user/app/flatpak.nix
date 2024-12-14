{
  lib,
  config,
  ...
}: let
  steam = "com.valvesoftware.Steam";
  steamUserId = "247800368";
  lutris = "net.lutris.Lutris";
in {
  # Used by gmodena/nix-flatpak for declarative management
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    packages = [
      lutris
      "com.github.tchx84.Flatseal"
      # Check Arch Wiki if rich presence does not work
      "com.discordapp.Discord"
      "info.portfolio_performance.PortfolioPerformance"
      steam
      "com.calibre_ebook.calibre"
      "org.qbittorrent.qBittorrent"
      "org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08" # this branch supports Lutris integration
      "org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08" # this branch supports Steam integration
    ];

    overrides = {
      "${lutris}" = {
        Context = {
          filesystems = [
            # Needed in order to make steam shortcuts from Lutris
            "~/.var/app/com.valvesoftware.Steam/data/Steam/userdata/${steamUserId}/config/shortcuts.vdf"
          ];
        };
      };
      ${steam} = {
        Context = {
          filesystems = [
            "~/.config/MangoHud:ro"
          ];
        };
        "Session Bus Policy" = {
          "org.freedesktop.Flatpak" = "talk";
        };
      };
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
