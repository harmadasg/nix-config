{ pkgs, inputs, ... }:

{
  imports = [
    ./btop.nix
    ./qbittorrent.nix
    ./portfolio.nix
    ./calibre.nix
    ./discord.nix
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
