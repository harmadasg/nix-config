{...}: {
  # disabledModules = ["programs/steam.nix"];
  #
  # imports = let
  #   steam-patched = builtins.fetchTarball {
  #     url = "https://github.com/asladic/nixpkgs/archive/patch-1.tar.gz";
  #     sha256 = "019dz9mmjzwxvx0pm88wi0fza9gkxbjy6925j219ib7a450f44k8";
  #   };
  # in [
  #   (import "${steam-patched}/nixos/modules/programs/steam.nix")
  # ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession = {
        enable = true;
        # steam.args = ["-gamepadui" "-steamos3" "-steampal"];
      };
    };
    gamescope = {
      enable = true;
      capSysNice = true;
      env = {
        STEAM_MULTIPLE_XWAYLANDS = "1";
      };
      args = [
        "--rt"
        "--prefer-output DP-1"
        "--output-width 1920"
        "--output-height 1080"
        "--xwayland-count 2"
      ];
    };
  };
}
