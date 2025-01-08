{ pkgs, inputs, ... }:

{
  imports = [
    ./flatpak.nix
    ./btop.nix
    ./kitty.nix
    ./neovim.nix
    ./firefox.nix
    ./ranger.nix
    ./mpv.nix
    ./git.nix
    ./lutris.nix
  ];
}
