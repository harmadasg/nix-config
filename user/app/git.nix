{ config, pkgs, ... }:

{
  programs.git = {
      enable = true;
      userName = "Gergely Harmadas";
      userEmail = "harmadasg@gmail.com";
  };
}
