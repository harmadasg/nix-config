{ config, pkgs, ... }:

{
  programs.git = {
      enable = true;
      settings = {
        user.name = "Gergely Harmadas";
        user.email = "harmadasg@gmail.com";
      };
  };
}
