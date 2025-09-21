{
  config,
  pkgs,
  userSettings,
  ...
}: {
  # Display manager
  # Hyprlock greetd backend might be available in the future
  # https://github.com/hyprwm/hyprlock/pull/731
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath;
        fit = "Cover";
      };
    };
    # TODO use Hyprland as the compositor for ReGreet
    cageArgs = ["-s" "-m" "last"]; # Only show on the last monitor
  };


  services.greetd.settings.initial_session = {
        command = "sh -c 'sleep .5; uwsm start hyprland-uwsm.desktop'"; # ¯\_(ツ)_/¯
        user = "${userSettings.username}";
    };
}

