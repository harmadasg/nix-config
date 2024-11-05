{ config, pkgs, ... }:

{
  # Hardware accelerated graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["amdgpu"];
}
