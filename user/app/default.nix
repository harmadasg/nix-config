{ pkgs, inputs, ... }:

{
  imports = [
    ./flatpak.nix
    ./btop.nix
    ./kitty.nix
    ./neovim.nix
    ./firefox
    ./element.nix
    ./ranger.nix
    ./mpv.nix
    ./git.nix
    ./lutris.nix
    ./heroic.nix
    ./idea.nix
    ./overskride.nix
  ];
}
