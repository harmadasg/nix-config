{ pkgs, inputs, ... }:

{
  imports = [
    ./base.nix
    ./linux.nix
  ];
}