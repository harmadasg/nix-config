{
  pkgs,
  inputs,
  ...
}: {
  # Hyprland
  programs.hyprland = {
    enable = true;
    # https://www.reddit.com/r/hyprland/comments/1hqcnk1/what_is_the_difference_here/
    withUWSM = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
