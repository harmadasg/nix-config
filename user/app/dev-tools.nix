{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jdk_headless
    maven
    python3
  ];
}
