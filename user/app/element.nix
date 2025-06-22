{ config, pkgs, ... }:

{
  # for first run use the below command to initialize secret store
  # element-desktop --password-store=gnome-libsecret
  programs.element-desktop = {
    enable = true;
  };
}
