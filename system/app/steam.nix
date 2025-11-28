{
  pkgs,
  config,
  ...
}: let
  mainMonitor = config.display.mainMonitor;
in {
  imports = [
    ./../../common/monitor-utils.nix
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true;
      extraPackages = with pkgs; [
        mangohud
      ];
    };
    gamescope = {
      enable = true;
      capSysNice = true;
      env = {
        STEAM_MULTIPLE_XWAYLANDS = "1";
      };
      args = [
        "--rt"
        "--prefer-output ${mainMonitor.output}"
        "--output-width ${mainMonitor.width}"
        "--output-height ${mainMonitor.height}"
        "--xwayland-count 2"
      ];
    };
  };
}
