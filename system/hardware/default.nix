{ pkgs, inputs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./controller.nix
    ./graphics.nix
    ./networking.nix
    ./sound.nix
  ];
}
