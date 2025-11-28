{ pkgs, inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./rofi.nix
    ./../../../common/monitor-utils.nix
  ];
}
